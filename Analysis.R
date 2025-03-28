#iporting the data
mydata=read.csv(file.choose(),header = TRUE)
View(colnames(mydata))

na_count <-sapply(mydata, function(y) sum(length(which(is.na(y)))))
na_count <- data.frame(na_count)
na_count


View(mydata)

#mydata=na.omit(mydata)
attach(mydata)



library(dplyr)
mydata=select(mydata,
              -IsThirdPartyConfirmed,
              -Currency,
              -AmountLoan,
              -DueDate,
              -PaidOnDate,
              -IsFinalPayBack,
              -PayBackId,
              -AmountLoan)
View(colnames(mydata))
str(mydata)


mydata=select(mydata,
              -CustomerId,
              -BatchId,
              -CurrencyCode,
              -ChannelId,
              -ProviderId,
              -ThirdPartyId,
              -TransactionStatus,
              -LoanApplicationId,
              -LoanId,
              -CountryCode)
View(colnames(mydata))
mydata=select(mydata,
              -TransactionStartTime,
              -IssuedDateLoan)
View(mydata)

# dt11= sort(sample(nrow(mydata), nrow(mydata)*.7))
# train<-mydata[dt11,]
# test<-mydata[-dt11,]




#mydata$DueDate=as.POSIXct(mydata$TransactionStartTime, format="%d/%m/%Y  %H:%M")
mydata$IssuedDateLoan=as.POSIXct(mydata$IssuedDateLoan, 
                                 format="%d/%m/%Y  %H:%M")
mydata$TransactionStartTime=as.POSIXct(mydata$TransactionStartTime,
                                  format="%d/%m/%Y  %H:%M")


Ftable=table(mydata$InvestorId)
Ftable
Ftable1=table(mydata$LoanId)
Ftable1
Ftable2=table(mydata$ChannelId)
Ftable2
Ftable3=table(mydata$CurrencyCode)
Ftable3
Ftable4=table(mydata$ProductCategory)
Ftable4
Ftable5=table(mydata$TransactionStatus)
Ftable5
Ftable6=table(mydata$ProductId)
Ftable6
Ftable7=table(mydata$SubscriptionId)
Ftable7
Ftable8=table(mydata$TransactionId)
Ftable8
Ftable9=table(mydata$CustomerId)
Ftable9
Ftable10=table(mydata$ThirdPartyId)
Ftable10
Ftable11=table(mydata$BatchId)
Ftable11


mydata$IsDefaulted=as.factor(mydata$IsDefaulted)

na_count <-sapply(mydata, function(y) sum(length(which(is.na(y)))))
na_count <- data.frame(na_count)
na_count

cutvalueT=cut(mydata$Value, breaks = c(49,1000,10000,
                               100000,7000000),
             labels = c("A","B","C","D"))
table(cutvalueT)
sum(!complete.cases(cutvalueT))
a=data.frame(categories=cutvalueT)
View(a)
mydata=mutate(mydata,cutvalueT)
View(mydata)
str(mydata$IssuedDa)
na_count <-sapply(mydata, function(y) sum(length(which(is.na(y)))))
na_count <- data.frame(na_count)
na_count

str(mydata)


mydata<- mydata %>% select(TransactionId, everything())
View(mydata)
colnames(mydata)


id=sample(2,nrow(mydata), prob = c(0.7,0.3),replace = T)
Train=mydata[id==1,]
Test=mydata[id==2,]
View(Test)
View(Train)
attach(Train)
na_count <-sapply(Train, function(y) sum(length(which(is.na(y)))))
na_count <- data.frame(na_count)
na_count

attach(Test)
na_count <-sapply(Test, function(y) sum(length(which(is.na(y)))))
na_count <- data.frame(na_count)
na_count
Train=na.omit(Train)
Test=na.omit(Test)
Train$InvestorId=droplevels(Train$InvestorId, exclude =c('InvestorId_3'))
table(Train$InvestorId)

Test$InvestorId=droplevels(Test$InvestorId, exclude =c('InvestorId_3'))
table(Test$InvestorId)




logit <- glm(InvestorId ~ Amount+
                 Value+ 
                 ProductCategory+
                 SubscriptionId+
                 cutvalueT+
                 SubscriptionId, 
               data =Train, family = "binomial")

logit
summary(logit)
logitp=predict(logit,newdata = Test,type = "response")
#as.numeric(paste(pred))
View(logitp)
fitted.results <- ifelse(logitp >= 0.5,2,1)
View(fitted.results)
table(fitted.results)




library(caret)
library(e1071)
mat=data.frame(InvestorIdpred=fitted.results,InvestorId=Test$InvestorId)
View(mat)
confusionMatrix(table(fitted.results,as.numeric(Test$InvestorId)))







#Logistic regression Model building
mylogit <- glm(IsDefaulted ~ Amount + Value+ 
                 InvestorId+ProductCategory+
                 cutvalue+ProductId+
                 SubscriptionId, 
               data =mydata, family = "binomial")

mylogit

mylogit1 <- glm(IsDefaulted ~ Amount + Value+ 
                 InvestorId+ProductCategory+
                 cutvalue+
                 SubscriptionId, 
               data =mydata, family = "binomial")

mylogit1

mylogit2 <- glm(IsDefaulted ~ Amount + Value+ 
                  InvestorId+ProductCategory+
                  cutvalue, 
                data =mydata, family = "binomial")

mylogit2
#remiving variable Value
datatobuildthemodel=na.omit(datatobuildthemodel)
str(datatobuildthemodel)
mylogit9 <- glm(IsDefaulted ~ Amount + 
                  
                  cutvalue+
                  SubscriptionId, 
                data =datatobuildthemodel, family="binomial")
                

mylogit9
pred9=predict(mylogit9, datatotest, type = "response")
View(pred9)
fitted.results <- ifelse(pred9 >= 0.5,1,0)
View(fitted.results)
table(fitted.results)

mylogit4 <- glm(IsDefaulted ~InvestorId+ProductCategory+
                  cutvalue+
                  SubscriptionId, 
                data =mydata, family = "binomial")

mylogit4
pred4=predict(mylogit4, data=datatotest, type = "response")
pred4

# misClasificError <- mean(fitted.results != datatotest$Survived)
# print(paste('Accuracy',1-misClasificError))








set.seed(2)
id=sample(2,nrow(mydata),prob = c(0.7,0.3),replace = TRUE)
train=mydata[id==1,]
test=mydata[id==2,]
View(test)
View(train)
attach(train)
View(colnames(train))

library(dplyr)

train=select(train,-TransactionStartTime,
             -TransactionId,-IssuedDateLoan)
colnames(train)

library(randomForest)
best<-tuneRF(train,train$IsDefaulted,
             stepFactor = 1.2,improve = 0.01,trace = T,
             plot = T,stringsAsFactors = FALSE)
best

model=randomForest(IsDefaulted~.,data=train)
model
importance(model)
varImpPlot(model)


test=select(train,-TransactionStartTime,
             -TransactionId,-IssuedDateLoan)
colnames(test)


pred=predict(model,newdata = test,type = "class")
#as.numeric(paste(pred))
View(pred)
table(pred)


library(dplyr)
Newdata=mutate(test,pred)
View(Newdata)

library(caret)
library(e1071)
confusionMatrix(table(pred,test$IsDefaulted))






mydata1=read.csv(file.choose(),header = TRUE)
View(mydata1)
colnames(mydata1)
sum(!complete.cases(mydata1))
na_count <-sapply(mydata1, function(y) sum(length(which(is.na(y)))))
na_count <- data.frame(na_count)
na_count
#mydata1=na.omit(mydata1)
View(mydata1)
str(mydata1)
attach(mydata1)

library(dplyr)
View(colnames(mydata1))


mydata1=select(mydata1,
               -CustomerId,
               -BatchId,
               -CurrencyCode,
               -ChannelId,
               -ProviderId,
               -ThirdPartyId,
               -TransactionStatus,
               -LoanApplicationId,
               -LoanId,
               -CountryCode)
View(colnames(mydata1))
View(colnames(train))
mydata1=select(mydata1,-TransactionStartTime)
mydata1=select(mydata1,-IssuedDateLoan)
mydata1=select(mydata1,-InvestorId)
mydata1=select(mydata1,-TransactionId)
colnames(mydata1)
colnames(test)

na_count <-sapply(mydata1, function(y) sum(length(which(is.na(y)))))
na_count <- data.frame(na_count)
na_count



cutvaluet=cut(mydata1$Value, breaks = c(49,1000,10000,50000,
                                      100000,400000,7000000),
             labels = c("A","B","C","D","E","F"))
sum(!complete.cases(cutvaluet))
b=data.frame(categories=cutvaluet)
View(b)
mydata1=mutate(mydata1,cutvaluet)
View(mydata1)
na_count1 <-sapply(mydata1, function(y) sum(length(which(is.na(y)))))
na_count1 <- data.frame(na_count1)
na_count1

View(colnames(mydata1))

mydata1=na.omit(mydata1
                )
View(mydata1)
colnames(mydata1)




colnames(mydata)
library(dplyr)
mydata_test=select(mydata,
                   -IssuedDateLoan,
                   -InvestorId,
                   -TransactionStartTime)
mydata_test=select(mydata_test,
                   -TransactionId)
colnames(mydata_test)
mydata_test=na.omit(mydata_test)
model2=randomForest(IsDefaulted~.,data=mydata_test)
model2
importance(model2)
varImpPlot(model2)




str(mydata1)
str(mydata_test)
colnames(mydata_test)
colnames(mydata1)
pred2=predict(model2,newdata = mydata1,type = "class")
#as.numeric(paste(pred))
View(pred2)
table(pred2)


library(dplyr)
Newdata=mutate(test,pred)
View(Newdata)

library(caret)
library(e1071)
confusionMatrix(table(pred,test$IsDefaulted))

str(mydata_test)
str(mydata1)
mydata1$ProductId=droplevels(mydata1$ProductId, exclude =c('ProductId_11',
                                                           'ProductId_14',
                                                           'ProductId_19',
                                                           'ProductId_2'))
str(mydata1$ProductId)

mydata_test$ProductId=droplevels(mydata_test$ProductId, exclude =c(
                                                               'ProductId_12',
                                                               'ProductId_17',
                                                               'ProductId_2',
                                                               'ProductId_16'))

str(mydata_test$ProductId)
str(mydata1$ProductId)
#deleting unused levels
mydata_test$SubscriptionId=droplevels(mydata_test$SubscriptionId, exclude =c(
                                                                        'SubscriptionId_2',
                                                                        'SubscriptionId_4'))
str(mydata_test$SubscriptionId)
table(mydata_test$SubscriptionId)
table(mydata1$SubscriptionId)


#recoding the levels of subscription variable
mydata1=mutate(mydata1, SubscriptionId = recode(SubscriptionId, 
                                                  SubscriptionId_3 = "SSubscriptionId_5",
                                                  SubscriptionId_5 = "SubscriptionId_6"
  )
  )

str(mydata1)
table(mydata1$SubscriptionId)

mydata1$ProductCategory=droplevels(mydata1$ProductCategory, exclude =c('ticket'))
table(mydata1$ProductCategory)



mydata_test$ProductCategory=droplevels(mydata_test$ProductCategory, exclude =c('movies'))
table(mydata_test$ProductCategory)

                                                        
str(mydata1)
str(mydata_test)
datatotest=mydata1
datatobuildthemodel=mydata_test

datatobuildthemodel=na.omit(datatobuildthemodel)
datatotest=na.omit(datatotest)


levels(datatobuildthemodel$SubscriptionId)=levels(datatotest$SubscriptionId)
levels(datatobuildthemodel$ProductId)=levels(datatotest$ProductId)
levels(datatobuildthemodel$ProductCategory)=levels(datatotest$ProductCategory)
levels(datatobuildthemodel$cutvalue)=levels(datatotest$cutvalue)
table(datatobuildthemodel$IsDefaulted)


library(randomForest)
modelnew=randomForest(IsDefaulted~.,data=datatobuildthemodel)
modelnew
importance(modelnew)
varImpPlot(modelnew)


prednew=predict(modelnew,newdata = datatotest,type = "class")
#as.numeric(paste(pred))
View(prednew)
table(prednew)


library(dplyr)
Newdata=mutate(test,pred)
View(Newdata)

library(caret)
library(e1071)
confusionMatrix(table(prednew,datatotes$IsDefaulted))



















?#specific row in r
   
   library(dplyr)
   result =filter(mydata, TransactionId=="TransactionId_1979"|Value>=400000)
     View(result)
     results1=filter(mydata,cutvalue==null)
     View(results1)
   summarise(Value)
mean(Value)   
min(Value)
max(Value)
cutvalue=cut(Value, breaks = c(100,1000,10000,50000,
                               100000,400000,3000000),
             labels = c("A","B","C","D","E","F"))
View(cutvalue)
#creating a data frame
a=data.frame(categories=cutvalue)
View(a)
mydata=mutate(mydata,cutvalue)
View(mydata)

