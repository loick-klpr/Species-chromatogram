%% 
clear all
close all
clc

%% load list 45 diatoms north sea
cd E:\matrices_data\cpr_env\
load valence_ecolo_phyto_ns_1997_2017_4.mat list_phyto_cpr

%% load data cpr env et abondance phyto 
cd E:\matrices_data\cpr_env\
load cpr_env_climato_depth_1997_2018.mat data_phyto cpr_env list_phyto data_eye list_eye data_trav list_trav label time_cpr
list_phyto_2=table2cell(list_phyto(:,2));
list_eye_2=table2cell(list_eye(:,2));
list_trav_2=table2cell(list_trav(:,2));

%% isole les 45 espèces d'intérets
clear test f
test=ismember(list_phyto_2,list_phyto_cpr);
f=find(test==0);
data_phyto(:,f)=[];
list_phyto_2(f)=[];

%% 1998-2018
clear f
f=find(time_cpr(:,1)<1998 | time_cpr(:,1)>2018);
cpr_env(f,:)=[];
data_eye(f,:)=[];
data_phyto(f,:)=[];
data_trav(f,:)=[];
time_cpr(f,:)=[];
unique(time_cpr(:,1))

%% chromatograms
[y_ps,~]=chromato_env16bis(cpr_env(:,[1:8 10]),data_phyto(:,1),50,20,5,2);
[y_sc,~]=chromato_env16bis(cpr_env(:,[1:8 10]),data_phyto(:,2),50,20,5,2);
[y_rs,~]=chromato_env16bis(cpr_env(:,[1:8 10]),data_phyto(:,5),50,20,5,2);
[y_rb,~]=chromato_env16bis(cpr_env(:,[1:8 10]),data_phyto(:,28),50,20,5,2);
test_phyto=cat(3,y_ps,y_sc,y_rs,y_rb);

[y_tl,~]=chromato_env16bis(cpr_env(:,[1 5:end]),data_trav(:,3),50,20,5,2);
[y_cl,~]=chromato_env16bis(cpr_env(:,[1 5:end]),data_trav(:,8),50,20,5,2);
[y_cf,~]=chromato_env16bis(cpr_env(:,[1 5:end]),data_eye(:,1),50,20,5,2);
[y_ch,~]=chromato_env16bis(cpr_env(:,[1 5:end]),data_eye(:,2),50,20,5,2);
test_zoo=cat(3,y_tl,y_cl,y_cf,y_ch);

for i=1:size(test_phyto,3)
    figure
    pcolor(test_phyto(:,:,i))
    colormap(jet)
    colorbar
end

for i=1:size(test_zoo,3)
    figure
    pcolor(test_zoo(:,:,i))
    colormap(jet)
    colorbar
end

[deg_eury_phyto,mean_deg_eury_phyto,opti_val_phyto]=opti_eury_niche2bis(test_phyto(1:end-1,1:end-1,:),0.05,cpr_env(:,[1:8 10]),data_phyto(:,[1 2 5 28]),5);
[deg_eury_zoo,mean_deg_eury_zoo,opti_val_zoo]=opti_eury_niche2bis(test_zoo(1:end-1,1:end-1,:),0.05,cpr_env(:,[1 5:end]),[data_trav(:,[3 8]) data_eye(:,[1 2])],5);

[results1_phyto]=combina_niche3bis(test_phyto(1:end-1,1:end-1,:),0.05);
[results1_zoo]=combina_niche3bis(test_zoo(1:end-1,1:end-1,:),0.05);
