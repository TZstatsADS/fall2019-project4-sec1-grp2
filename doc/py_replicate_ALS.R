library(Matrix)

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
r <- 10

als.function <- function(){
  
  

  
  
  p <- matrix(runif(U, -1, 1), ncol = U, nrow = r) #User matrix
  colnames(p) <- as.character(1:U)
  q <- matrix(runif(M, -1, 1), ncol = M, nrow = r) 
  colnames(q) <- levels(as.factor(data$movieId)) #Movie Matrix
  
  train_RMSE <- c()
  test_RMSE <- c()
  
  #Creating indicator matrix
  I <- matrix(runif(U, 0, 1),ncol = U, nrow = M)
  I[I > 0] = 1
  I[I == 0] = 0
  
  #Step 1, initialize q by assigning average rating for that movie as the first row.
  
  new.row <- data %>% 
    group_by(movieId) %>%
    summarise(Mean.Rating = mean(rating)) %>%
    select(Mean.Rating) #Taking all mean ratings
  
  
  q[1,] <- as.vector(new.row$Mean.Rating) #Assign mean ratings to first row
  
  E <- diag(r) #r x r identity matrix
  
  
  mu <- mean(new.row$Mean.Rating) #Average of all the mean ratings
  iter <- 0
  user.count<-c()
  final.user.count <- c()
  A <- matrix(NA,nrow = U, ncol = M)
  V <- matrix(NA, nrow = M, ncol = 10)
  
  while (iter < max.iter) {
    
    #Fix q and solve p
    
    for (u in 1:U) {
      
      user.count <- sum(I[u,])
      
      final.user.count[u] <- ifelse(user.count[u] == 0,1,user.count[u])
      
      #Least Squares Solution
      
      A[u,] <- (q %*% (diag(I) %*% t(q))) + lambda*(final.user.count %*% E)
      
      V[u,] <- (q %*% (diag(I) %*% ))
      
    }
    
    A <- A + user.bias
    V <- V + movie.bias
    #solve?
    
    
  }
  