nanmean4<-function(x,n){
  p<-length(x)
  
  p1<-ceiling((n*p[1])/100)
  
  ind<-sort(x,decreasing = TRUE)
  y<-mean(ind[1:p1],na.rm = TRUE)
}