rm(list = ls())


#bootstrap regression
intercept <- as.matrix(read.table("intercept.txt"))
coefficient <- as.matrix(read.table("coef.txt"))

#distribution plot
require(ggplot2)
p<-ggplot(data.frame(coefficient), aes(x=coefficient)) +
  geom_density(color="darkblue", fill="lightblue",alpha = 0.4)
p
#estimate and normality assumption test
mean(coefficient)
var(coefficient)
t_stat = mean(coefficient)/sd(coefficient)
1-pnorm(t_stat)

# 95 percentile confidence interval
quantile(coefficient,c(0.025,0.975))


#F-stat p-value
Fstat <- as.matrix(read.table("Fstat.txt"))
sum(Fstat > 1961.403) / nrow(Fstat)
