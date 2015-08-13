



#this function generates a dataset composed of two N-dimensional normal distributions each with a 
#diagonal covariance matrix (i.e., just variances). The function also outputs the Bayes accuracies (micro and macro)
gaussians_ndim <- function(N=2, n0=2000, SD0=1, n1=2000, SD1=1, d=3, empirical=FALSE){
  #N = number of dimensions of each gaussian distribution
  #n1 = number of examples minority class
  #SD1 = stand. dev. minority class
  #n0=  the same for majority class
  #SD0= the same for majority class
  #d = distance between the means of the two distributions
  #empirical= If true, mu (mean) and Sigma (SD) specify the empirical but not population mean and covariance matrix.
  require(MASS)
  require(R2Cuba)
  
  results <- list()
  
  sigma1 <- SD1*diag(N)
  x1<-mvrnorm(n = n1, mu=c(1,rep(0, N-1)), Sigma=sigma1, empirical=empirical)
  l1 <- rep(1,n1) #class labels
  
  sigma0 <- SD0*diag(N)
  x0 <-mvrnorm(n = n0, mu=rep(0,N), Sigma=sigma0, empirical=empirical)
  l0 <- rep(0,n0)
  
  df <- cbind(x1,l1)
  df <- rbind(df, cbind(x0,l0))
  
  f_micro <-make.f_micro_ndim(N=N,n0=n0, SD0=SD0, n1=n1, SD1=SD1, d=d)
  f_macro <-make.f_macro_ndim(N=N, n0=n0, SD0=SD0, n1=n1, SD1=SD1, d=d)
  
  bayes_micro <- vegas(N, 1, f_micro,lower=rep(-50,N), upper=rep(50,N))$value  
  bayes_macro <- vegas(N, 1, f_macro,lower=rep(-50,N), upper=rep(50,N))$value
  
  results$df <- df
  results$bayes_micro <- bayes_micro
  results$bayes_macro <- bayes_macro
  
  return(results)  
}


make.f_micro_ndim <- function(N,n0, SD0, n1, SD1, d){
  
  f_micro <-function(x){    
    prior1 <- n1/(n0+n1)
    prior0 <- n0/(n0+n1)
    for(i in 1:N){
       if(i==1){
         f1 <- prior1*dnorm(x[i],d,SD1)
         f0 <- prior0*dnorm(x[i],0,SD0)
       }
      else{
        f1 <- f1*dnorm(x[i],0,SD1)
        f0 <- f0*dnorm(x[i],0,SD0)
      }
    }
    return(max(f1,f0)) 
  }
  
  return(f_micro) 
}



make.f_macro_ndim <- function(N,n0, SD0, n1, SD1, d){
  
  f_macro <-function(x){    
    for(i in 1:N){
      if(i==1){
        f1 <- dnorm(x[i],d,SD1)
        f0 <- dnorm(x[i],0,SD0)
      }
      else{
        f1 <- f1*dnorm(x[i],0,SD1)
        f0 <- f0*dnorm(x[i],0,SD0)
      }
    }
    return(max(f1,f0)/2) 
  }
  
  return(f_macro) 
}
