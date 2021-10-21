opti_eury_niche2<-function(sp_chr,T,z,y,k){
  n<-dim(sp_chr)
  deg_eury=matrix(nrow = n[2],ncol = n[3])
  opti_val=matrix(nrow = n[2],ncol = n[3])
  
  # estimation of niche breadth
  for (j in 1:n[3]) {
    for (i in 1:n[2]) {
      temp<-sp_chr[,i,j]
      f1<-which(temp>=T)
      temp[f1[1]:f1[length(f1)]]<-1
      f2<-which(!is.na(temp))
      f3<-which(temp>=T)
      deg_eury[i,j]<-(length(f3)*100)/length(f2)
      rm(temp,f1,f2,f3)
    }
  }
  deg_eury<<-deg_eury
  mean_deg_eury<<-colMeans(deg_eury)
  
  #estimation of niche optimums
  catego<-seq(0, 1, by = (1/n[1]))
  z1<-catego[1:length(catego)-1]
  z2<-catego[2:length(catego)]
  
  n2<-dim(z)
  env_st<-matrix(nrow = n2[1],ncol = n2[2])
  
  for (i in 1:n[2]){
    env_st[,i]<-(z[,i]-min(z[,i],na.rm = TRUE))/(max(z[,i],na.rm = TRUE)-min(z[,i],na.rm = TRUE))
  }
  
  for (j in 1:n[3]) {
    for (i in 1:n[2]) {
      temp<-sp_chr[,i,j]
      f1<-which(temp==max(temp,na.rm = TRUE))
      f2<-which(env_st[,i]>=z1[f1[1]] & env_st[,i]<z2[f1[length(f1)]])
      temp_abund<-y[f2,j]
      temp_env<-z[f2,i]
      p1<-ceiling((k*length(temp_abund))/100)
      ind<-order(temp_abund,decreasing = TRUE)
      opti_val[i,j]<-mean(temp_env[ind[1:p1]],na.rm = TRUE)
      rm(temp,temp_abund,temp_env,p1,ind,f1,f2)
    }
  }
  opti_val<<-opti_val
}
