chromato_env16<-function(z,y,alpha,m,k,order_smth){
  source("nanmean4.R")
  source("moymob1.R")
  
  n<-dim(z)
  xst<-matrix(nrow = n[1],ncol = n[2])
  
  for (i in 1:n[2]){
    xst[,i]<-(z[,i]-min(z[,i],na.rm = TRUE))/(max(z[,i],na.rm = TRUE)-min(z[,i],na.rm = TRUE))
  }
  
  catego<-seq(0, 1, by = (1/alpha))
  z1<-catego[1:length(catego)-1]
  z2<-catego[2:length(catego)]
  
  chr1<-matrix(nrow = length(z1), ncol = n[2])
  nbval<-matrix(nrow = length(z1),ncol = n[2])
  
  for (i in 1:length(z1)) {
    for (j in 1:n[2]) {
      
      if (i==length(z1)){
        f<-which(xst[,j]>=z1[i] & xst[,j]<=z2[i])
      }else{
        f<-which(xst[,j]>=z1[i] & xst[,j]<z2[i])
      }
      
      if (length(xst[f,j])>=m){
        chr1[i,j]<-nanmean4(y[f],k)
        nbval[i,j]<-length(xst[f,j])
      }
      rm(f)
    }
  }
  
  chr2<-matrix(nrow = length(z1), ncol = n[2])

  for (i in 1:n[2]) {
    tps<-moymob1(chr1[,i],order_smth)
    chr2[,i]<-tps/max(tps,na.rm = TRUE)
  }
  
  library(colorRamps)
  library(ggplot2)
  library(reshape2)
  
  y2<-as.data.frame(chr2)
  y2$category<-factor(1:alpha)
  y3<<-melt(y2)
  chrom_plot<-ggplot(y3,aes(x=variable, y=category, colour=0, fill=value)) + geom_tile() + 
    scale_fill_gradientn(colours=blue2green2red(400)) + scale_color_gradientn(colours="#000000") + guides(colour="none") + 
    labs(fill = "Standardised\nabundance") + xlab("Environmental variables")
  print(chrom_plot) 
  
  chr2<-chr2
}
  
  