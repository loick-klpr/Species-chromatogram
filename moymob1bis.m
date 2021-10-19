% simple moving average
% To use in 'chromato_env16.m'
% INPUTS:
% x: matrix with in lines the observations and in column the variables
% m: window size (2m+1)
%
% OUTPUTS:
% y: estimation
%
% Grégory Beaugrand Février 2004

function y=moymob1bis(x,m);

%++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
[n,p]=size(x); 
fenetre=2*m+1;
y=zeros(n,p)+nan;
%++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
% main program
for i=m+1:n-m
   y(i,:)=nanmean(x(i-m:i+m,:));
end
%++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
% Estimation of the lower end 
m2=m;
while m2~=1
   m2=m2-1;
   for i=m2+1:m
       y(i,:)=nanmean(x(i-m2:i+m2,:));
   end
end
y(1,:)=mean(x(1:2,:));
%++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
% Estimation of the upper end
m2=m;
while m2~=1
   m2=m2-1;
	for i=n-m+1:n-m2
      y(i,:)=nanmean(x(i-m2:i+m2,:));
	end
end
y(n,:)=mean(x(n-1:n,:));
%++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
   

   
   
   


