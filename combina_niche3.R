combina_niche3<-function(sp_chr,T){
  source("niche_difer_sp.R")
  n<-dim(sp_chr)
  v<-(1:n[2])
  nb<-0
  
  for (i in 1:n[2]) {
    temp<-t(combn(v,i))
    ntemp<-dim(temp)
    nb<-ntemp[1]+nb
    rm(temp,ntemp)
  }
  
  
  point<-matrix(nrow = nb,ncol = 1)
  point2<-matrix(nrow = nb,ncol = n[2])
  y<-array(data=NA,dim = c(n[3],n[3],nb))
  moyenne<-matrix(nrow = nb,ncol = 1)
  
  cp<-0
  for (i in 1:n[2]) {
    temp<-t(combn(v,i))
    ntemp<-dim(temp)
    
    for (j in 1:ntemp[1]) {
      cp<-cp+1
      y[,,cp]<-niche_difer_sp(sp_chr[,temp[j,],],T)
      point[cp]<-i
      point2[cp,1:i]<-temp[j,1:i]
      
      test<-y[,,cp]
      test2<-upper.tri(test,diag = FALSE)
      moyenne[cp]<-mean(test[test2==TRUE],na.rm = TRUE)
      rm(test,test2)
    }
    rm(temp,ntemp)
  }
  
  results1<-matrix(nrow = n[2],ncol = n[2]+2)
  
  for (i in 1:n[2]) {
    f<-which(point==i)
    temp1<-moyenne[f]
    mini<-min(temp1,na.rm = TRUE)
    pos<-which(temp1==mini)
    results1[i,]<-t(c(i,point2[f[pos],],mini))
    rm(f,temp1,mini,pos)
  }
  results1<-results1
}
