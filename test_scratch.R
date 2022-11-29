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

# this runs correctly on the entire data set !

for (col.id in 1:ncol(miss.features)){
  for (z in which(is.na(miss.features[,col.id]), arr.ind = T)){  
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

###################################################################

# What does the performance looks like?

for (j in 1:ncol(miss.features)){
  b<-which(is.na(miss.features[,j]), arr.ind=T)
  print((Z[b,j]-copy.miss.features[b,j]))
}


##################################################################


# Save performance to list object for review later

#create list to store performance on each vector


#save(acc.list, file='impute_degree_only.RData')


###############################################################


# Let's try to improve out distance function k 


for (col.id in 1:ncol(miss.features)){
  for (z in which(is.na(miss.features[,col.id]), arr.ind = T)){  
    j <- as.integer(neighborhood(network, order=2)[[z]])
    k <- abs(V(network)$degree[z] - V(network)$degree[neighborhood(network, order=2)[[z]]]) + abs(V(network)$betweenness[z] - V(network)$betweenness[neighborhood(network, order=2)[[z]]])
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



for (col.id in 1:ncol(miss.features)){
  for (z in which(is.na(miss.features[,col.id]), arr.ind = T)){  
    j <- as.integer(neighborhood(network, order=2)[[z]])
    k <- abs(V(network)$betweenness[z] - V(network)$betweenness[neighborhood(network, order=2)[[z]]])
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


for (col.id in 1:ncol(miss.features)){
  for (z in which(is.na(miss.features[,col.id]), arr.ind = T)){  
    j <- as.integer(neighborhood(network, order=2)[[z]])
    k <- abs(V(network)$eigen[z] - V(network)$eigen[neighborhood(network, order=2)[[z]]])
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


for (j in 1:ncol(miss.features)){
  b<-which(is.na(miss.features[,j]), arr.ind=T)
  print((Z[b,j]-copy.miss.features[b,j]))
}


acc.list.dgbw <- list()
for (j in 1:ncol(miss.features)){
  b<-which(is.na(miss.features[,j]), arr.ind=T)
  acc.list.dgbw[[j]] <- (Z[b,j]-copy.miss.features[b,j])
}

acc.list.bw <- list()
for (j in 1:ncol(miss.features)){
  b<-which(is.na(miss.features[,j]), arr.ind=T)
  acc.list.bw[[j]] <- (Z[b,j]-copy.miss.features[b,j])
}

acc.list.eg <- list()
for (j in 1:ncol(miss.features)){
  b<-which(is.na(miss.features[,j]), arr.ind=T)
  acc.list.eg[[j]] <- (Z[b,j]-copy.miss.features[b,j])
}

#save(acc.list.eg, file="impute_eg_only.RData")

#save(acc.list.bw, file="impute_bw_only.RData")

#save(acc.list.dgbw, file="impute_degree_bw.RData")

#load("impute_degree_only.RData")
#load("impute_degree_bw.RData")



acc.list
acc.list.dgbw

for (h in 1:length(acc.list)){

print(abs(sum(acc.list[[h]])))
  
}


for (h in 1:length(acc.list)){
  
  print(sum(abs(acc.list[[h]]))-sum(abs(acc.list.bw[[h]])))
  
}



for (h in 1:length(acc.list.bw)){
  
  print(sum(abs(acc.list.bw[[h]])))
  
}


for (h in 1:length(acc.list)){
  
  print(sum(abs(acc.list[[h]]))-sum(abs(acc.list.eg[[h]])))
  
}




v1<-NA
for (h in 1:length(acc.list)){
  
  v1<-append(v1,(sum(abs(acc.list[[h]]))))
  
}



v2 <- NA
for (h in 1:length(acc.list)){
  
  v2<-append(v2,print(sum(abs(acc.list.eg[[h]]))))
  
}


v3 <- NA
for (h in 1:length(acc.list)){
  
  v3<-append(v3,print(sum(abs(acc.list.bw[[h]]))))
  
}

cbind(v1,v2,v3)

V(network)$close[23]
