function y=nanmean4(x,k)
% To use in 'chromato_env16.m'
% Estimates the mean of the k% of the samples with the highest abundance
% 
% 
% Input :
% x = vector with the values to average
% k = an integer corresponding to the percentage of samples with the highest abundance values to use to estimate the mean abundance in a given category
%
% Output :
% y = mean of the k% of the samples with the highest abundance values
%
% Grégory Beaugrand & Loïck Kléparski Juin 2021

p=size(x,1);
p1=ceil((k*p)/100);

[~,ind]=sort(x,'descend');
y=mean(x(ind(1:p1)),'omitnan');
