#Code for the final project
#Convert to rmd file when complete
library(tidyverse)
getwd()
setwd('C:/Users/Trent/Desktop/Data Science Specialization/Course 8 - ML/Final_Project')
dir()
test <- read_csv('pml-testing.csv')
test <- test[, -1] %>% dplyr::select(-user_name, -new_window, -num_window, 
                                     -matches('timestamp'), -matches('kurtosis'), 
                                     -starts_with('kurtosis'), -starts_with('skewness'), 
                                     -starts_with('max_'), -starts_with('min_'), 
                                     -starts_with('amplitude_'), -starts_with('avg_'), 
                                     -starts_with('stddev_'), -starts_with('var_'))

train <- read_csv('pml_training.csv')
train <- train %>% filter(new_window == 'no') %>% dplyr::select(-X1, -user_name, -new_window, -num_window, 
                                                                     -matches('timestamp'), -matches('kurtosis'), 
                                                                     -starts_with('kurtosis'), -starts_with('skewness'), 
                                                                     -starts_with('max_'), -starts_with('min_'), 
                                                                     -starts_with('amplitude_'), -starts_with('avg_'), 
                                                                     -starts_with('stddev_'), -starts_with('var_'))
colnames(train)
#consider using 'num_window' to merge training and test set to determine the class for the prediction quiz
#training and test sets are ready to use...