source("chromato_env16.R")
source("opti_eury_niche2.R")
source("combina_niche3.R")

cpr_env<-read.csv("cpr_env.csv",header = FALSE,sep = ",",dec = ".",na='NaN')
data_phyto<-read.csv("data_phyto.csv",header = FALSE,sep = ",",dec = ".")
data_trav<-read.csv("data_trav.csv",header = FALSE,sep = ",",dec = ".")
data_eye<-read.csv("data_eye.csv",header = FALSE,sep = ",",dec = ".")
time_cpr<-read.csv("time_cpr.csv",header = FALSE,sep = ",",dec = ".")

y_psulcata<-chromato_env16(cpr_env[,c(1:8,10)],data_phyto[,1],50,20,5,2)
y_scosta<-chromato_env16(cpr_env[,c(1:8,10)],data_phyto[,2],50,20,5,2)
y_rstyli<-chromato_env16(cpr_env[,c(1:8,10)],data_phyto[,5],50,20,5,2)
y_rbergonii<-chromato_env16(cpr_env[,c(1:8,10)],data_phyto[,28],50,20,5,2)

y_tlongi<-chromato_env16(cpr_env[,c(1,5:10)],data_trav[,3],50,20,5,2)
y_claus<-chromato_env16(cpr_env[,c(1,5:10)],data_trav[,8],50,20,5,2)
y_cfin<-chromato_env16(cpr_env[,c(1,5:10)],data_eye[,1],50,20,5,2)
y_chel<-chromato_env16(cpr_env[,c(1,5:10)],data_eye[,2],50,20,5,2)

library(abind)
test_phyto<-abind(y_psulcata,y_scosta,y_rstyli,y_rbergonii,along=3)
test_zoo<-abind(y_tlongi,y_claus,y_cfin,y_chel,along=3)
seuil<-0.5

#opti_eury_niche2(test_phyto,seuil,cpr_env[,c(1:8,10)],data_phyto[,c(1,2,5,28)],5)
opti_eury_niche2(test_zoo,seuil,cpr_env[,c(1,5:10)],cbind(data_trav[,c(3,8)],data_eye[,c(1,2)]),5)

#combi_dim_phyto<-combina_niche3(test_phyto,seuil)
combi_dim_zoo<-combina_niche3(test_zoo,seuil)
