library(dplyr)
library(Hmisc)
library(anytime)
library(lubridate)

#Function to assigning time bins for temporal regularization

assign.bins <- function(df) {
  

    
    TEST <-df %>%
            mutate(New.Time = as.Date(anytime(timestamp))) %>%
            mutate(Year = year(ymd(New.Time))) 
    
    TEST$Bin <- group_indices(TEST,Year)
    
     return(TEST %>%
             select(userId,movieId,rating,Year,Bin))
  
  
}


#Define a function to calculate RMSE
RMSE <- function(rating, est_rating){
  sqr_err <- function(obs){
    sqr_error <- (obs[3] - est_rating[as.character(obs[2]), as.character(obs[1])])^2
    return(sqr_error)
  }
  return(sqrt(mean(apply(rating, 1, sqr_err))))  
}


#Alternating Least Squares

U <- length(unique(data$userId)) #Number of users
M <- length(unique(data$movieId)) #Number of movies
alpha <- 5
beta <- 0.4



max.iter <- 10

als.function <- function(){
  


  
  p <- matrix(runif(U, -1, 1), ncol = U, nrow = M) #User matrix
  colnames(p) <- as.character(1:U)
  q <- matrix(runif(M, -1, 1), ncol = M, nrow = U) 
  colnames(q) <- levels(as.factor(data$movieId)) #Movie Matrix

  train_RMSE <- c()
  test_RMSE <- c()
  
  
  #Step 1, initialize q by assigning average rating for that movie as the first row.
  
  new.row <- data %>% 
    group_by(movieId) %>%
    summarise(Mean.Rating = mean(rating)) %>%
    select(Mean.Rating) #Taking all mean ratings
    
  
  q[1,] <- as.vector(new.row$Mean.Rating) #Assign mean ratings to first row
  

  

  mu <- mean(new.row$Mean.Rating) #Average of all the mean ratings
  
  data <- assign.bins(data) #Assigning bins
  
  b.i <- new.row$Mean.Rating - mu #Overall movie bias
  
  new.data <- data %>%
    group_by(userId) %>%
    summarise(b = mean(rating))
  
  b.u <- new.data$b - mu #Overall user bias
  
  new.data <- data %>%
    group_by(Bin) %>%
    summarise(Bias = mean(rating))
  
  bin.bias <- new.data$Bias - mu #Bias for each bin (year)
  
  b.i.bin <- data %>%
    mutate(Bin.Bias = ifelse())
  
  new.data <- data %>%
    group_by(userId) %>%
    summarise(t = mean(Bin))
  
  t.u <- new.data$t #Mean bin for each user 
  
  bin.index <- unique(data$Bin) #Bin index (1:23) 
  
  dev.t.u <- rep(NA,U)
  b.u.t <- rep(NA,U)
  


  for (t in 1:length(bin.index)) {
    
    current.bin <- t
   
    for (u in 1:U) {
      
      dev.t.u[u] <- sign(current.bin - t.u[u])*(abs(current.bin-t.u[u]))^beta #Time deviation for each user
      
      b.u.t[u] <- b.u[u] + alpha*dev.t.u[u] #User bias with time deviations 
       
     
      
    }  

    
    
  }
   
   

  
  for (m in 1:U) {
    
    #Step 2: Fix q and minimize p (sum over users)
    
    p[,m] <- b.i + mu + b.u[m] + alpha*dev.t.u[m] + b.u.t[m] + (q[m,])*p[,m] #+ bin.bias[t] #Assigning row of estimated ratings for each user
    
    
  }
  
  #Step 3: Fix p and minimize q
  
  for (n in 1:U) {
    n<-1
    
    q[n,] <- b.i + mu + b.u[n] + alpha*dev.t.u[n] + b.u.t[n] + (q[n,])*p[,n]
    
  }
  

}
  



  
    
#error <- sum (actual rating - r.i.t^2) + lambda*(norm(q)^2+norm(p^2 + b.u^2 + b.i^2))
  error <- sum(((r.u - q[,i] * p[,u])^2)+lambda*(norm(q)^2 + norm(p)^2))
  

  





ggplot(data,aes(x=timestamp)) + geom_histogram(color="blue",fill="lightblue",binwidth = 20) 
+ ggtitle("Histogram of Time Stamps")















