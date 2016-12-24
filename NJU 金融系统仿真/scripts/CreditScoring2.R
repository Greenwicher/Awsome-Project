setwd("e:/tmp/fss_h/data")
getwd()
set.seed(2013)

library(RSADBE)
library(ROCR)
library(randomForest)
library(rpart)

## get data from csv file
maxr=10000
data<-read.csv('give me some credit/cs-training.csv')
data<-data[1:maxr,]
data$SeriousDlqin2yrs<-as.factor(ifelse(data$SeriousDlqin2yrs==0, 'good', 'bad'))

filter<-function(data){
  attach(data)
  indices<-!(is.na(MonthlyIncome+NumberOfOpenCreditLinesAndLoans+NumberOfTimes90DaysLate+NumberRealEstateLoansOrLines+NumberOfTime60_89DaysPastDueNotWorse+NumberOfDependents))
  return(data[indices,])
  
}

data<-filter(data)

## seperate the data set into two domains, train and test set
train.rate=0.6
d=sort(sample(nrow(data), nrow(data)*train.rate))
train=data[d,]
test=data[-d,]

## logistic regression
fit1<-glm(SeriousDlqin2yrs~., data=train, family=binomial(link="logit"))
summary(fit1)
write.csv(coef(summary(fit1)),  'logistic2.csv')
test$score1<-predict(fit1, type='response', test)
pred1<-prediction(test$score1, test$SeriousDlqin2yrs)
perf1<-performance(pred1, 'tpr', 'fpr')

# top 3 reasons
g<-predict(fit1,type='terms',test)  
ftopk<- function(x,top=3){  
  
  res=names(x)[order(x, decreasing = TRUE)][1:top] 
  paste(res,collapse=";",sep="") 
} 
# Application of the function using the top 3 rows 
topk=apply(g,1,ftopk,top=3) 


## simple Classficatioin Tree
fit2<-rpart(SeriousDlqin2yrs~.,data=train) 
plot(fit2, main='Classfication Tree');text(fit2); 
test$score2<-predict(fit2,type='prob',test)[,2] 
pred2<-prediction(test$score2,test$SeriousDlqin2yrs) 
perf2<-performance(pred2,"tpr","fpr") 

# generate rules
listrules<-function(model) 
{ 
  
  if (!inherits(model, "rpart")) stop("Not a legitimate rpart tree") 
  # 
  # Get some information. 
  # 
  frm<- model$frame 
  names<-row.names(frm) 
  ylevels<-attr(model, "ylevels") 
  ds.size<-model$frame[1,]$n 
  # 
  # Print each leaf node as a rule. 
  # 
  for(i in 1:nrow(frm)) 
  { 
    if (frm[i,1] == "<leaf>" & ylevels[frm[i,]$yval]=='bad') 
    { 
      # The following [,5] is hardwired - needs work! 
      cat("\n") 
      cat(sprintf(" Rule number: %s ", names[i])) 
      cat(sprintf("[yval=%s cover=%d N=%s Y=%s (%.0f%%) prob=%0.2f]\n", 
                  ylevels[frm[i,]$yval], frm[i,]$n,  
                  formatC(frm[i,]$yval2[,2], format = "f", digits = 2), 
                  formatC(frm[i,]$n-frm[i,]$yval2[,2], format = "f", digits  
                          = 2), 
                  round(100*frm[i,]$n/ds.size), frm[i,] 
                  $yval2[,5])) 
      pth <- path.rpart(model, nodes=as.numeric(names[i]),  
                        print.it=FALSE) 
      cat(sprintf("   %s\n", unlist(pth)[-1]), sep="") 
    } 
  } 
} 

listrules(fit2) 


## random forests
memory.limit(50000)
fit3<-randomForest(SeriousDlqin2yrs~., data=train, importance=TRUE, proximity=TRUE, ntree=10, keep.forest=TRUE)
# importance variables
varImpPlot(fit3, main='Variable Importance measured by Random Forests')
plot(fit3, main='Error Rates of Random Forests')
test$score3<-predict(fit3,test,type='prob')[,2] 
pred3<-prediction(test$score3,test$SeriousDlqin2yrs) 
perf3<-performance(pred3,"tpr","fpr") 

# top 3 reasons
# add reason list to scored tets sample 
test<-cbind(test, topk)


## performance evaluation
# ROC (Receiver Operating Characteristic) Curve
plot(perf1, col='red', main='Logistic Regression, Classfication Tree, Random Forests')
plot(perf2, col='green', add=TRUE)
plot(perf3, col='blue', add=TRUE)
legend(0.8,0.4,c('LR','CT','RF'),col=c('red','green','blue'),lwd=3) 


# KS statistic, mostly used in industry
ks1<-max(attr(perf1,'y.values')[[1]]-attr(perf1,'x.values')[[1]]) 
ks2<-max(attr(perf2,'y.values')[[1]]-attr(perf2,'x.values')[[1]]) 
ks3<-max(attr(perf3,'y.values')[[1]]-attr(perf3,'x.values')[[1]]) 
ks<-c(ks1, ks2, ks3)

# Area under ROC Curve
auc1<-attr(performance(pred1, 'auc'), 'y.values')[[1]]
auc2<-attr(performance(pred2, 'auc'), 'y.values')[[1]]
auc3<-attr(performance(pred3, 'auc'), 'y.values')[[1]]
auc<-c(auc1, auc2, auc3)

# accuracy rate
acc1<-max(attr(performance(pred1, 'acc'), 'y.values')[[1]])
acc2<-max(attr(performance(pred2, 'acc'), 'y.values')[[1]])
acc3<-max(attr(performance(pred3, 'acc'), 'y.values')[[1]])
acc<-c(acc1, acc2, acc3)

# optimal cutoff point
list1<-unlist(attr(performance(pred1, 'acc'), 'x.values')[[1]])
list2<-unlist(attr(performance(pred2, 'acc'), 'x.values')[[1]])
list3<-unlist(attr(performance(pred3, 'acc'), 'x.values')[[1]])
cutoff1<-list1[which.max(attr(performance(pred1, 'acc'), 'y.values')[[1]])]
cutoff2<-list2[which.max(attr(performance(pred2, 'acc'), 'y.values')[[1]])]
cutoff3<-list3[which.max(attr(performance(pred3, 'acc'), 'y.values')[[1]])]
cutoff<-c(cutoff1, cutoff2, cutoff3)

colnames<-c('Model', 'KS statistic', 'Area under the Curve', 'Accuracy Rate', 'Optimal Cutoff')
model<-c('Logistic Regression', 'Classfication Tree', 'Random Forests')
stat<-data.frame(model, ks, auc, acc, cutoff)
colnames(stat)=colnames
write.csv(stat, 'stat2.csv')

save.image('CreditScoring2.RData')
