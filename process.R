library(tidytext)
library(dplyr)
library(SnowballC)
high_wordcount = c()
low_wordcount = c()
for (i in 1:80) {
  f = file(paste('stat605m3/helpful/',as.character(i),'_helpful_.txt',sep = ""))
  f1 = readLines(f)
  close(f)
  all = as.integer(sub("[0-9]*/","",f1))
  of = as.integer(sub("/[0-9]*","",f1))
  percent = of/all
  g = file(paste('stat605m3/text/',as.character(i),'_text_.txt',sep = ""))
  f2 = readLines(g)
  close(g)
  f2<-iconv(f2,"WINDOWS-1252","UTF-8")
  amazon_text_high = tolower(as.character(f2[all>=10][percent[all>=10]>=0.5]))
  amadata_high = data.frame(text = amazon_text_high, stringsAsFactors = F)
  tidy_amadata_high<- amadata_high %>%
    select(text) %>%
    unnest_tokens("word", text)
  data("stop_words")
  tidy_amadata_high<-tidy_amadata_high %>%
    anti_join(stop_words)
  final_high = tidy_amadata_high %>%
    count(word) %>%
    arrange(desc(n))
  high_wordcount = rbind(high_wordcount,final_high)
  amazon_text_low = tolower(as.character(f2[all>=10][percent[all>=10]<0.5]))
  amadata_low = data.frame(text = amazon_text_low, stringsAsFactors = F)
  tidy_amadata_low<- amadata_low %>%
    select(text) %>%
    unnest_tokens("word", text)
  data("stop_words")
  tidy_amadata_low<-tidy_amadata_low %>%
    anti_join(stop_words)
  final_low = tidy_amadata_low %>%
    count(word) %>%
    arrange(desc(n))
  low_wordcount = rbind(low_wordcount,final_low, stringsAsFactors = F)
}

low_wordcount = low_wordcount[order(as.character(low_wordcount[,1])),]
high_wordcount = high_wordcount[order(as.character(high_wordcount[,1])),]




merge1 <- function(wordcount){
  new_word = c()
  new_count = c()
  new_word[1] = wordcount[1,1]
  new_count[1] = wordcount[1,2]
  j = 1
  for(i in 1:(length(wordcount[,1])-1)){
    if (wordcount[i,1] == wordcount[i+1,1]){
      new_count[j] = new_count[j] + wordcount[i+1,2]
    }else{
      j = j+1
      new_word[j] = wordcount[i+1,1]
      new_count[j] = wordcount[i+1,2]
    }
  }
  new = data.frame(word = new_word, count = new_count, stringsAsFactors = F)
  return(new)
}
high_wordcount_merge = merge1(high_wordcount)
low_wordcount_merge = merge1(low_wordcount)
low_wordcount_merge = low_wordcount_merge[order(low_wordcount_merge[,2],decreasing = T),]
high_wordcount_merge = high_wordcount_merge[order(high_wordcount_merge[,2],decreasing = T),]
install.packages('wordcloud2')
library(wordcloud2)
wordcloud2(data = high_wordcount_merge[2:200,])
wordcloud2(data = low_wordcount_merge[2:200,])
wordcloud2(demoFreq)





