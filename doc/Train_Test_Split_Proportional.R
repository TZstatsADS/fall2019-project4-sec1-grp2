#Split Train and Test Set
library(splitstackshape)
library(dplyr)

set.seed(1)

data <- read.csv("./data/ml-latest-small/ratings.csv")

#using 60% of each category in train set and 40% in test set
train.users <- stratified(data,c("userId"),.6)
hold<-anti_join(data,train.users)
train.movies <- stratified(hold,c("movieId"),.6)

data_train <- rbind(train.users,train.movies)
data_test <- anti_join(data,data_train)

data_test <- data_test %>%
  select(-X)

data_train <- data_train %>%
  select(-X)

write.csv(data_train,file = "./output/data_train_proportional.csv")
write.csv(data_test,file = "./output/data_test_proportional.csv")

head(data_test)
dim(data_test)
dim(data_train)
