#Split Train and Test Set
library(splitstackshape)
library(dplyr)

set.seed(1)

test.users <- stratified(data,c("userId"),5)
hold<-anti_join(data,test.users)
test.movies <- stratified(hold,c("movieId"),5)

data_test <- rbind(test.users,test.movies)
data_train <- anti_join(data,data_test)

data_test <- data_test %>%
  select(-X)

data_train <- data_train %>%
  select(-X)


write.csv(data_train,file = "../output/data_train.csv")
write.csv(data_test,file = "../output/data_test.csv")
