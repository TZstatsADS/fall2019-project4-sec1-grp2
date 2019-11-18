library(dplyr)
library(Hmisc)

#Assigning time bins for temporal regularizations

unique.timestamps <- unique(data$timestamp)
time.key <- as.data.frame(unique.timestamps) %>%
  group_by()
time.key %>% arrange(timestamp) #orders time.key by ascending timestamp (assumes ALS function splits into bins by timestamp below)
#bins <- split(time.key, (0:nrow(time.key) %/% 30)) #if ALS code below doesn't automatically split it into equal groups. can change the number of bins in this line

#Define a function to calculate RMSE
RMSE <- function(rating, est_rating){
  sqr_err <- function(obs){
    sqr_error <- (obs[3] - est_rating[as.character(obs[2]), as.character(obs[1])])^2
    return(sqr_error)
  }
  return(sqrt(mean(apply(rating, 1, sqr_err))))  
}


#Alternating Least Squares

U <- length(unique(data$userId))
I <- length(unique(data$movieId))
alpha <- 5
beta <- 0.4
num.bins <- 30

als.function <- function(){

  p <- matrix(runif(U, -1, 1), ncol = U) #User matrix
  colnames(p) <- as.character(1:U)
  q <- matrix(runif(I, -1, 1), ncol = I) 
  colnames(q) <- levels(as.factor(data$movieId)) #Movie Matrix

  train_RMSE <- c()
  test_RMSE <- c()
  
  
  #Step 1, initialize q by assigning average rating for that movie as the first row.
  
  new.row <- data %>% 
    group_by(movieId) %>%
    summarise(Mean.Rating = mean(rating)) %>%
    select(Mean.Rating) #Taking all mean ratings
    
  
  q[1,] <- as.vector(new.row$Mean.Rating)
  
  mu <- mean(new.row$Mean.Rating) #Average of all the mean ratings
  
  for (t in 1:num.bins) {
    
    bin.dat <- data[data$time.group == t,]
  
#Step 2: Fix q and minimize p (sum over users)?
  
    for (s in 1:U) {
      
      t.u <- mean(bin.dat$time.group)
      
      dev.ut <- sign(t-t.u)*(abs(t-t.u)^beta)
      
      b.i <- (mean(q[,s])-mu) 
      
      r.u.t <- mu + (mean(p[,s])-mu) + alpha*dev.ut + b.i #+ bi.bin.t
      
      r.u[t] <- r.u.t
    }
    
    #makes sense to iterate with changing user bias for each minimization iteration over p and with changing item bias for each minimization iteration over q?
    #makes sense to use vectors instead of line by line here?
    #section 3.1 Large-scale Parallel Collaborative Filtering for the Netflix Prize
    #(movie matrix * movie matrix _transpose + lamda normalization identity)* user matrix
    #(user matrix * user matric_transpose + lambda normalization identity)* movie matrix

    
 #Step 3 Fix p and solve q
    
    r.i.t <- mu + b.u + b.i + bi.bin.t # we think this should be in the iteration, but that only move 
    
    
#error <- sum (actual rating - r.i.t^2) + lambda*(norm(q)^2+norm(p^2 + b.u^2 + b.i^2))
  error <- sum(((r.u - q[,i] * p[,u])^2)+lambda*(norm(q)^2 + norm(p)^2))
  

  
  
  }


  
  
  
}




















