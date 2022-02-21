function [deg_eury,mean_deg_eury,opti_val]=opti_eury_niche2(sp_chr,T,z,y,k)

% Input :
% 
% sp_chr : matrix with the species chromatograms (categories by environmental variables by species). Outputs of 'chromato_env16.m'
%
% T = abundance threshold 
%
% z = matrix with n samples by p environmental variables (i.e. the value of each environmental varibale in each sample)
%
% y = matrix with species abundance in the n samples
%
% k = an integer corresponding to the percentage of samples with the highest abundance values to use to estimate the mean abundance in a given category
%
% Outputs :
%
% deg_eury = degree of euryecie (niche breadth) for each species along each environmental dimensions (matrix environmental variable by species)
%
% mean_deg_eury = mean degree of euryecie of each species
%
% opti_val = niche optimum values (matrix environmental variables by species)

% Loïck Kléparski, Mai 2021

%% initialisation
clear n p w
[n,p,w]=size(sp_chr);

deg_eury=nan(p,w);
opti_val=nan(p,w);

%% estimation of niche breadths
for j=1:w
    for i=1:p
        clear f1 f2 f3 temp
        temp=sp_chr(:,i,j);
        
        if T==0
            f1=find(temp>T);
        else
            f1=find(temp>=T);
        end
        
        temp(f1(1):f1(end))=1;
        f2=find(isnan(temp)==0);
        
        if T==0
            f3=find(temp>T);
        else 
            f3=find(temp>=T);
        end
        
        deg_eury(i,j)=(length(f3)*100)/length(f2);   
    end
end

mean_deg_eury=mean(deg_eury,1);

%% estimation of niche optimum values
catego=[0:1./(n):1]';
z1=catego(1:end-1,:);
z2=catego(2:end,:);

[n1,p1]=size(z);
env_st=nan(n1,p1);

for i=1:p1
    env_st(:,i)=(z(:,i)-min(z(:,i)))./(max(z(:,i))-min(z(:,i)));
end

for j=1:w
    for i=1:p
        clear f1 f2 temp temp_abund p1 ind temp_env
        temp=sp_chr(:,i,j);
        
        f1=find(temp==max(temp,[],'omitnan'));                        
        f2=find(env_st(:,i)>=z1(f1(1)) & env_st(:,i)<z2(f1(end)));            
        
        temp_abund=y(f2,j);
        temp_env=z(f2,i);
        
        p1=ceil((k*size(temp_abund,1))/100);
    
        [~,ind]=sort(temp_abund,'descend');
        
        opti_val(i,j)=mean(temp_env(ind(1:p1)),'all','omitnan');
    end
end

