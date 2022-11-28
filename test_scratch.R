# test with quantiles 
for (z in which(is.na(miss_features$age), arr.ind = T)){
  
  j <- as.integer(neighborhood(network, order=2)[[z]])
  k <- abs(V(network)$degree[z] - V(network)$degree[neighborhood(network, order=2)[[z]]])
  R <- as.data.frame(cbind(j,k,miss_features[j,1]))
  
  if (nrow(na.omit(R)) <= 1) {
    copy.miss.features[z,1] <- as.data.frame(na.omit(R$V3)) 
    
  }
  
  R.n <- na.omit(R[k<=quantile(R$k, na.rm=T, probs = c(.75)),])
  val <- R.n[as.integer(runif(1,1,nrow(R.n))),3]
  copy.miss.features[z,1] <- val
}




# go over each column
for (col.id in 1:ncol(miss_features)){
  for (z in which(is.na(miss_features[,col.id]), arr.ind = T)){
    
    j <- as.integer(neighborhood(network, order=2)[[z]])
    k <- abs(V(network)$degree[z] - V(network)$degree[neighborhood(network, order=2)[[z]]])
    R <- as.data.frame(cbind(j,k,miss_features[j,col.id]))
    
    if (nrow(na.omit(R)) <= 1) {
      copy.miss.features[z,1] <- as.data.frame(na.omit(R$V3)) 
      
    }
    
    R.n <- na.omit(R[k<=quantile(R$k, na.rm=T, probs = c(.75)),])
    val <- R.n[as.integer(runif(1,1,nrow(R.n))),3]
    copy.miss.features[z,col.id] <- val
  }
  
}







copy.miss.features <- miss.features


#improve filtering with k 
for(col.id in 1:ncol(copy.miss.features)){
  for(z in which(is.na(copy.miss.features[,col.id]), arr.ind = T)){
    j <- as.integer(neighborhood(network, order=2)[[z]])
    k <- abs(V(network)$degree[z] - V(network)$degree[neighborhood(network, order=2)[[z]]])
    R <- na.omit(as.data.frame(cbind(j,k,miss.features[j,col.id])))
    
    if (nrow(R) <= 1) {
      copy.miss.features[z,col.id] <- as.data.frame(R$V3) 
    }else{
    R <- R[order(R$k),]
    R <- R[1:as.integer(.25*nrow(R)),]
    val <- R[sample(1:nrow(R),size=1),3]
    copy.miss.features[z,col.id] <- val
    }
  }
}

b<-which(is.na(miss.features[,1]), arr.ind=T)
Z[b,1]-copy.miss.features[b,1]



################################################################

# this functions correctly on the data set 
for (col.id in 1:ncol(miss_features)){
  for (z in which(is.na(miss_features[,col.id]), arr.ind = T)){  
    j <- as.integer(neighborhood(network, order=2)[[z]])
    k <- abs(V(network)$degree[z] - V(network)$degree[neighborhood(network, order=2)[[z]]])
    R <- na.omit(as.data.frame(cbind(j,k,miss.features[j,col.id])))
    
    if (nrow(R) == 1) {copy.miss.features[z,col.id] <- as.data.frame(R$V3)} 
    if (nrow(R) == 0) {copy.miss.features[z,col.id] <- sample(na.omit(miss.features[,col.id]),size=1)}else
    {
      R <- R[order(R$k),]
      R <- R[1:as.integer(.25*nrow(R)),]
      val <- R[sample(1:nrow(R),size=1),3]
      copy.miss.features[z,col.id] <- val
    }
  }
}

#create list to store performance on each vector
acc.list <- list()
for (j in 1:ncol(miss.features)){
b<-which(is.na(miss.features[,j]), arr.ind=T)
acc.list[[j]] <- (Z[b,j]-copy.miss.features[b,j])
}

#save(acc.list, file='impute_degree_only.RData')


###############################################################



# across each column no quantiles (still gets stuck)

for (col.id in 1:ncol(miss_features)){
  for (z in which(is.na(miss_features[,col.id]), arr.ind = T)){
    
    j <- as.integer(neighborhood(network, order=2)[[z]])
    k <- abs(V(network)$degree[z] - V(network)$degree[neighborhood(network, order=2)[[z]]])
    R <- as.data.frame(cbind(j,k,miss_features[j,col.id]))
    
    if (nrow(na.omit(R)) <= 1) {
      copy.miss.features[z,col.id] <- as.data.frame(na.omit(R$V3)) 
      
    }
    
    R.n <- na.omit(R)
    val <- R.n[as.integer(runif(1,1,nrow(R.n))),3]
    copy.miss.features[z,col.id] <- val
  }
  print(col.id) 
}







# gets stuck on col18 lets investigate
