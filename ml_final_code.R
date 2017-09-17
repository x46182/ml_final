#Code for the final project
#Convert to rmd file when complete
library(tidyverse)
library(caret)
getwd()
setwd('C:/Users/Trent/Desktop/Data Science Specialization/Course 8 - ML/Final_Project')
dir()
test <- read_csv('pml-testing.csv')

test <- test[, -1] %>% dplyr::select(-user_name, -new_window, -num_window, 
                                     -matches('timestamp'), 
                                     -starts_with('kurtosis'), -starts_with('skewness'), 
                                     -starts_with('max_'), -starts_with('min_'), 
                                     -starts_with('amplitude_'), -starts_with('avg_'), 
                                     -starts_with('stddev_'), -starts_with('var_'))

train <- read_csv('pml_training.csv')
train <- train %>% filter(new_window == 'no') %>% 
        dplyr::select(-X1, -user_name, -new_window, -num_window,
                      -matches('timestamp'), 
                      -starts_with('kurtosis'), -starts_with('skewness'), 
                      -starts_with('max_'), -starts_with('min_'), 
                      -starts_with('amplitude_'), -starts_with('avg_'), 
                      -starts_with('stddev_'), -starts_with('var_'))
colnames(train)
#consider using 'num_window' to merge training and test set to determine the class for the prediction quiz
#training and test sets are ready to use...

#Let's try a couple models without doing any preprocessing or cross validation

sum(is.na(train$classe))
head(train)
sum(is.na(train))#there are 3 missing values in row 5270
apply(train, 2, function(x) which(is.na(x)))
train <- train[-5270, ]

mod.rf <- train(classe ~ . , method = 'rf', data = train) #plain Random Forest algorithm
#need to take a look at 'rfcv' function to avoid overfitting...
save.image('ml_final.RData')
confusionMatrix(train$classe, predict(mod.glm.pca, train))
#we may want to consider pre-processing with PCAs to reduce the dimensionality of the data
#we can also think about cross validation since we have a rather large 'n' ~20K observations
#also consider standardizing the data....

#The out of sample error rate should be a little higher than what our error rate is for the testing set.  Be sure
#to explicitly say this in the report.
mod.glm <- train(as.factor(classe) ~ . , method = 'glm' , preProcess = 'pca', data = train)
mod.rpart <- train(as.factor(classe) ~. , method = 'rpart', data = train)
pred2 <- predict(mod.rpart, train)
sum(pred2 == train$classe)/length(pred2)

length(train$classe)
mod.gbm <- train(as.factor(classe) ~. , method = 'gbm', data = train)
pred3 <- predict(mod.gbm, train)
sum(pred3 == train$classe)/length(train$classe)

pred4 <- predict(mod.gbm, test)
pred4
library(caret)
confusionMatrix(pred3, train$classe)
qplot(jitter(pred3), train$classe, color = (pred3 == train$classe))
save.image('ml_final.RData')
load('ml_final.RData')
