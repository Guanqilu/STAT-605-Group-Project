rm(list = ls())

args = commandArgs(trailingOnly=TRUE)
fileNum = args[1]

#convert data
# score <- read.table("score.txt",sep = "\n")
# raw_help <- read.table("helpful.txt",sep = "\n",colClasses = "character")
# str2num <- function(x){ return(eval(parse(text=x))) }
# help <- as.data.frame(apply(raw_help,1,str2num))
# df <- data.frame(c(score, help))
# colnames(df) <- c("score","help_rate")
# df_na_rm <- df[complete.cases(df), ]

# write.csv(df_na_rm,file = "regression.csv",row.names = FALSE)
reg <- read.csv("combine.csv")
# plot(reg[1:1000,1],reg[1:1000,2])
# model1 <- lm(data = reg, score~help_rate)
# summary(model1)

#resampling
for (i in 1:100) {
set.seed(rnorm(1,10000,10000))
ind <- sample(1:nrow(reg),nrow(reg),replace = TRUE)
data = reg[ind,]
model <- lm(data = data, score~help_rate)

cat(file=paste0(fileNum,"_coef.out"), model$coef[2],"\n",append = TRUE)
cat(file=paste0(fileNum,"_intercept.out"), model$coef[1],"\n",append = TRUE)
}

