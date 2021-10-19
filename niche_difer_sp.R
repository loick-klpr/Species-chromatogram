niche_difer_sp<-function(sp_chr,T){
  source("niche_difer2.R")
  n<-dim(sp_chr)
  y2<-matrix(nrow = n[length(n)],ncol = n[length(n)])
  
  if (length(n)==2) {
    for (i in 1:(n[length(n)]-1)) {
      for (j in ((i+1):n[length(n)])) {
        y2[i,j]<-niche_difer2(as.matrix(sp_chr[,i]),as.matrix(sp_chr[,j]),T)
      }
    }
    
  }else{
    for (i in 1:(n[length(n)]-1)) {
      for (j in ((i+1):n[length(n)])) {
        y2[i,j]<-niche_difer2(as.matrix(sp_chr[,,i]),as.matrix(sp_chr[,,j]),T)
      }
    }
  }
  
  y2<-y2
}