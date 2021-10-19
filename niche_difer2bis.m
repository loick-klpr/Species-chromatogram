function D=niche_difer2bis(sp_chr1,sp_chr2,T)
% To use in 'niche_difer_sp.m'
% INPUTS:
%
% sp_chr1: matrix (niche categories by environmental variables) for species 1
% sp_chr2: matrix (niche categories by environmental variables) for species 2
% Columns in spe_chr1 and sp_chr2 have to be the same
%
% T: the threshold of minimal abundance in a category for the niche breadth estimation
%
% OUTPUTS:
%
% D: index D
%
% Grégory Beaugrand Avril 2021

sp_chr1(sp_chr1>=T)=1;
sp_chr1(sp_chr1<T)=0;

sp_chr2(sp_chr2>=T)=1;
sp_chr2(sp_chr2<T)=0;

[n,p]=size(sp_chr1);
for i=1:p
    clear temp1 temp2 f1 f2
    temp1=sp_chr1(:,i);
    temp2=sp_chr2(:,i);
    f1=find(temp1==1);
    f2=find(temp2==1);
    sp_chr1(f1(1):f1(end),i)=1;
    sp_chr2(f2(1):f2(end),i)=1;
end
D=zeros(n,p)+nan;

a1=sp_chr1+sp_chr2;
f1=find(a1==2);

a2=zeros(n,p);
a2(f1)=1;

a3=nansum(a2,1);
z=prod(a3,2);

a4=nansum(sp_chr1,1);
a5=prod(a4,2);

a6=nansum(sp_chr2,1);
a7=prod(a6,2);

D=(100.*z)./(a5+a7-z);




