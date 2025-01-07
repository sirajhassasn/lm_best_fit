
rm(list=ls())
setwd("C:\\Users\\KHAN\\Downloads\\archive (1)")
data<-read.csv("CarPrice_Assignment.csv")
dim(data)
head(data)
mydata<-data.frame(data[,c(26,2,10:13,17,19:25)])
head(mydata)
#----FULL MODEL-----#
lm(price~.,data=mydata)
summary(lm(price~.,data=mydata))
#----Compute all possble models----#
variables <- colnames(mydata)[2:ncol(mydata)]
formulas <- list()
for (i in seq_along(variables)) {
  tmp <- combn(variables, i)
  tmp <- apply(tmp, 2, paste, collapse="+")
  tmp <- paste0("price~", tmp)
  formulas[[i]] <- tmp
}
formulas <- unlist(formulas)
formulas <- sapply(formulas, as.formula)
#-----  8191 estiamated models----#
models <- lapply(formulas, lm, data=mydata)
length(models)
summary(models[[1]])$r.square
summary(models[[2]])$r.square
summary(models[[3]])
summary(models[[4]])
summary(models[[5]])
summary(models[[6]])
summary(models[[8191]])
summary(models[[50]])$r.square

summary<-matrix(0,length(models),3)
for(i in 1:length(models)){
summary[i,1]<-summary(models[[i]])$r.square
summary[i,2]<-AIC(models[[i]])
summary[i,2]<-BIC(models[[i]])

}
head(summary)
