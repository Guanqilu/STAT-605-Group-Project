rm(list = ls())

args = commandArgs(trailingOnly=TRUE)
fileNum = args[1]

#read the data
reg <- read.csv("combine.csv")

#the regression of text length and  score
for (i in 1:100) {    
reg$new <- sample(reg$score,nrow(reg))
model <- lm(text_count~as.factor(new),reg)
Fstat <- unname(summary(model)$fstatistic['value'])
cat(file=paste0(fileNum,"_Fstat.out"), model$coef[2],"\n",append = TRUE)
}
