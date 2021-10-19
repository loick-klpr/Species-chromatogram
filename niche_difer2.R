niche_difer2<-function(sp_chr1,sp_chr2,T){
  sp_chr1[sp_chr1>=T]<-1
  sp_chr1[sp_chr1<T]<-0
  
  sp_chr2[sp_chr2>=T]<-1
  sp_chr2[sp_chr2<T]<-0
  
  n<-dim(sp_chr1)
  for (i in 1:n[length(n)]) {
    f1<-which(sp_chr1[,i]==1)
    f2<-which(sp_chr2[,i]==1)
    sp_chr1[f1[1]:f1[length(f1)],i]<-1
    sp_chr2[f2[1]:f2[length(f2)],i]<-1
    rm(f1,f2)
  }
  
  y<-matrix(nrow = n[1],ncol = n[2])
  a1<-sp_chr1+sp_chr2
  f1<-which(a1==2)
  
  a2<-matrix(nrow = n[1],ncol = n[2])
  a2[f1]<-1
  
  z<-prod(colSums(a2,na.rm=TRUE),na.rm=TRUE)
  a3<-prod(colSums(sp_chr1,na.rm=TRUE),na.rm=TRUE)
  a4<-prod(colSums(sp_chr2,na.rm=TRUE),na.rm=TRUE)
  
  D<-(100*z)/(a3+a4-z)
}