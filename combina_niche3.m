function [results1]=combina_niche3(sp_chr,T)
% Needs 'niche_difer_sp.m' and 'niche_difer2.m'
% INPUTS:
%
% sp_chr: a matrix with the species chromatograms (categories by environmental variables by species). Outputs of 'chromato_env16.m'
% T: the threshold of minimal abundance in a category for niche breadth estimation
%
% OUTPUTS:
%
% results1: The mean degree of niche overlapping. The first column displays the number of dimensions 
% considered simultaneously, columns 2 to 10 display the combinations of dimensions. 
% The last column displays index D associated with the combination of environmental dimensions. 
% D=0 when species niches are fully different and D=100 when species niches are identical; 
% the higher the number of dimensions, the lower the value of index D. 
% Only the combinations of environmental variables that minimise values of index D are displayed.
%
% Grégory Beaugrand Avril 2021

[~,p,z]=size(sp_chr);        % CATEGORIES X DIMENSIONS X ESPECES
v=[1:p];
nb=0;
for i=1:p
    clear temp ntemp ptemp
    temp=combnk(v,i);
    [ntemp,~]=size(temp);
    nb=ntemp+nb;
end
clear temp ntemp ptemp

point=zeros(nb,1)+nan;
point2=zeros(nb,p)+nan;
y=zeros(z,z,nb)+nan;
moyenne=zeros(nb,1)+nan;

cp=0;
for i=1:p
    clear temp ntemp ptemp 
    temp=combnk(v,i);
    [ntemp,~]=size(temp);
    for j=1:ntemp
        cp=cp+1;
        y(:,:,cp)=niche_difer_sp(sp_chr(:,temp(j,:),:),T);
        point(cp,1)=i;
        point2(cp,1:i)=temp(j,1:i);
        
        clear test test2 test3 temp2
        test=ones(z,z);test2=triu(test,1);
        test3=squeeze(y(:,:,cp));
        temp2=test3(test2==1);
        moyenne(cp,1)=mean(temp2,'omitnan');
    end
end

results1=nan(p,p+2);

for i=1:p
    clear f temp1
    f=find(point==i);
    temp1=moyenne(f,1);
    [mini1,val1]=min(temp1,[],1,'omitnan');
    results1(i,:)=[i point2(f(val1),:) mini1];
end
