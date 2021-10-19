function y=niche_difer_sp(sp_chr,T)
% To use in 'combina_niche3.m'
% INPUTS:
%
% sp_chr: three dimensional matrices with the species chromatograms (alpha category by p environmental variables by species)
% T: the threshold of minimal abundance in a category for the niche breadth estimation
% 
% OUTPUTS:
%
% y: index D
%
% Grégory Beaugrand Avril 2021

[~,~,z]=size(sp_chr);
y=zeros(z,z)+nan;
for i=1:z
    for j=i+1:z
        y(i,j)=niche_difer2(squeeze(sp_chr(:,:,i)),squeeze(sp_chr(:,:,j)),T);
    end
end

