
library(igraph)
library(mice)
set.seed(1987)

load("C:/Users/ajd430/Desktop/Rotations/imputation_project/Glasgow-demographic.RData")
load("C:/Users/ajd430/Desktop/Rotations/imputation_project/Glasgow-friendship.RData")
load("C:/Users/ajd430/Desktop/Rotations/imputation_project/Glasgow-geographic.RData")
load("C:/Users/ajd430/Desktop/Rotations/imputation_project/Glasgow-lifestyle.RData")
load("C:/Users/ajd430/Desktop/Rotations/imputation_project/Glasgow-selections.RData")
load("C:/Users/ajd430/Desktop/Rotations/imputation_project/Glasgow-substances.RData")
load("C:/Users/ajd430/Desktop/Rotations/imputation_project/Glasgow-various.RData")


Y <- cbind(age,sex.F,tobacco[,1],romantic[,1],music1,money[,1],leisure1,familysmoking, dist.school, cannabis[,1], alcohol[,1])
Z <- na.omit(Y)
ind <- rownames(Z)
ajd <- friendship.1[ind,ind]


# convert to undirected network for now
W <- ifelse(ajd==2,1,ifelse(ajd==1,1,0))


# create network object
network <- graph.adjacency(W, mode='undirected', diag=F)

Z <- as.data.frame(Z)

# attach attributes from cleaned feature matrix
#vertex_attr(network) <- Z


# check plot
plot.igraph(network, vertex.size = 6)

# simulate MAR in features
miss.features <- ampute(Z, prop=.95, mech='MAR')
miss.features <- miss.features$amp
#View(miss_features)


# remove entire rows (non-responders)

miss.features[sample(1:84,replace=F,size=12),] <-NA
#View(miss_features)
vertex_attr(network) <- miss.features

# Z is the truth. 


# Degree centrality
network_deg <- degree(network,mode=c("All"))
V(network)$degree <- network_deg
V(network)$degree

# Betweenness centrality
network_bw <- betweenness(network, directed = FALSE)
V(network)$betweenness <- network_bw

# eigen vector centrality 
eigen <- eigen_centrality(network, directed=F)
V(network)$eigen <- eigen$vector

# closeness
close <- closeness(network)
V(network)$close <- close






#compare stats for actor 2 with the rest of the network 
abs(V(network)$degree[2]-V(network)$degree[-2])
abs(V(network)$betweenness[2]-V(network)$betweenness[-2])


#sort closest actors
sort(abs(V(network)$degree[2]-V(network)$degree[-2]),index.return = TRUE)$ix[1:10]
sort(abs(V(network)$betweenness[2]-V(network)$betweenness[-2]),index.return = TRUE)$ix[1:10]

# not a lot of overlap here, unfortunate. 


na.omit(V(network)$age[sort(abs(V(network)$degree[2]-V(network)$degree[-2]),index.return = TRUE)$ix[1:10]])

V(network)$age[sort(abs(V(network)$betweenness[2]-V(network)$betweenness[-2]),index.return = TRUE)$ix[1:10]]

plot(network, vertex.size=12)


# look at the neighborhood of each vertex order 2 and draw??
sample(na.omit(V(network)$age[neighborhood(network, order=2)[[2]]]), size=1)

# composition of functions
# find the neighborhood first
# j = actor id
j <- as.integer(neighborhood(network, order=2)[[2]])
j               
# now compare network statistics with those actors in the neighborhood
# k is the stat value or "distance"
k <- abs(V(network)$degree[2] - V(network)$degree[neighborhood(network, order=2)[[2]]])

# combine into frame and sort [actor id, stat value, possible imputation values associated with each] 
R<-as.data.frame(cbind(j,k,miss.features[j,1]))

# filter matrix to bottom half of values in k (computed "distance") remove NAs and then sample this is our match
sample(na.omit(R[k<=quantile(R$k, na.rm=T, probs = c(.5)),])$V3, size=1)

copy.miss.features <- miss.features

# can we get this over one column to start?

master.list <- which(is.na(miss.features),arr.ind = T)


#  this works note this makes no use of k it only imputes based off the order 2 neighborhood
for (col.id in 1:ncol(miss.features)){
for (z in which(is.na(miss.features[,col.id]), arr.ind = T)){
  j <- as.integer(neighborhood(network, order=2)[[z]])
  k <- abs(V(network)$degree[z] - V(network)$degree[neighborhood(network, order=2)[[z]]])
  R <- as.data.frame(cbind(j,k,miss.features[j,col.id]))
  
  if (nrow(na.omit(R)) <= 1) {
    val <- sample(na.omit(miss.features[,col.id]),size=1)
    copy.miss.features[z,col.id] <- val
    } else{
    R.n <- na.omit(R)
    val <- R.n[as.integer(runif(1,1,nrow(R.n))),3]
    copy.miss.features[z,col.id] <- val
  }
}

}

# performance?
for (u in 1:ncol(miss.features)){
print(u)
b<-which(is.na(miss.features[,u]), arr.ind=T)
print(length(b))
print(Z[b,u]-copy.miss.features[b,u])
}



# TO-DO
# 1) Summarize the performance in some kind of table
# 2) Improve current method to include k (distance) 







