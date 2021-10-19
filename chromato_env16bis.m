function [chr2,nbval]=chromato_env16bis(z,y,alpha,m,k,order_smth)
% Needs 'nanmean4.m' and 'moymob1.m'
% INPUTS:
%
% z: matrix with n samples by p environmental variables (i.e. the value of each environmental varibale in each sample)
% y: vector with the abundance of a species in the n samples
% alpha: an integer corresponding to the number of category along each environmental variable
% m: an integer corresponding to the lowest number of samples needed in a category in order to have an estimation of the mean abundance
% k: an integer corresponding to the percentage of samples with the highest abundance values to use to estimate the mean abundance in a given category
% order_smth: an integer corresponding the order of the simple moving average applied along each niche dimension
%
% OUTPUTS: 
%
% y: species chromatogram (alpha categories by p environmental variables)
% nbval: nulber of samples available in each category along each niche dimension 
%
% Grégory Beaugrand and Loïck Kléparski Avril 2021

[n,p]=size(z);
xst=zeros(n,p)*nan;
for i=1:p
    xst(:,i)=(z(:,i)-min(z(:,i)))./(max(z(:,i))-min(z(:,i)));
end

catego=[0:1./(alpha):1]';    
z1=catego(1:end-1,:);
z2=catego(2:end,:);

yt=zeros(length(z1),p)+nan;
nbval=zeros(length(z1),p)+nan;

for i=1:length(z1)
    for j=1:p
        clear f
        if i==length(z1)
            f=find(xst(:,j)>=z1(i) & xst(:,j)<=z2(i));
        else
            f=find(xst(:,j)>=z1(i) & xst(:,j)<z2(i));
        end
        
        if length(f)>=m
            yt(i,j)=nanmean4(y(f,1),k);
            nbval(i,j)=length(f);
        end
    end
end

chr=zeros(alpha,size(z,2))*nan;
for i=1:p
    clear temp;
    temp=moymob1(yt(:,i),order_smth);
    chr(:,i)=(temp)./(max(temp));
end

chr2=[[chr zeros(alpha,1)*nan];zeros(1,size(z,2)+1)*nan];


