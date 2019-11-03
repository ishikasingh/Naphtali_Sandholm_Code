function [A, B, C] = ABC(xpart,f,j)
% finding A B C matrix for a given j
% using numerical differentiation (central difference) for evaluating each
% differential
% stageX functions return values for a stage (for a given j)
del=100;
c=5;
%B
A=zeros(2*c+1,2*c+1);
C=zeros(2*c+1,2*c+1);

for i=1:2*c+1
x1=xpart;
x1(i,j)= x1(i,j)+x1(i,j)/del;
Hdel_u=stageH(x1,f,j);
Mdel_u=stageM(x1,f,j);
Edel_u=stageE(x1,j);
x2=xpart;
x2(i,j)= x2(i,j)-x2(i,j)/del;
Hdel_l=stageH(x2,f,j);
Mdel_l=stageM(x2,f,j);
Edel_l=stageE(x2,j);
dhdi(i)=(Hdel_u-Hdel_l)/(2*xpart(i,j)/del);
dmdi(:,i)=(Mdel_u-Mdel_l)/(2*xpart(i,j)/del);
dedi(:,i)=(Edel_u-Edel_l)/(2*xpart(i,j)/del);
end

B = vertcat(dhdi,dmdi,dedi);   

%A
if j>1
for i=1:2*c+1
x1=xpart;
x1(i,j-1)= x1(i,j-1)+x1(i,j-1)/del;
Hdel_u=stageH(x1,f,j);
Mdel_u=stageM(x1,f,j);
Edel_u=stageE(x1,j);
x2=xpart;
x2(i,j-1)= x2(i,j-1)-x2(i,j-1)/del;
Hdel_l=stageH(x2,f,j);
Mdel_l=stageM(x2,f,j);
Edel_l=stageE(x2,j);
dhdi(i)=(Hdel_u-Hdel_l)/(2*xpart(i,j-1)/del);
dmdi(:,i)=(Mdel_u-Mdel_l)/(2*xpart(i,j-1)/del);
dedi(:,i)=(Edel_u-Edel_l)/(2*xpart(i,j-1)/del);
end

A = vertcat(dhdi,dmdi,dedi);  

 end

% %C
 if j<19
for i=1:2*c+1
x1=xpart;
x1(i,j+1)= x1(i,j+1)+x1(i,j+1)/del;
Hdel_u=stageH(x1,f,j);
Mdel_u=stageM(x1,f,j);
Edel_u=stageE(x1,j);
x2=xpart;
x2(i,j+1)= x2(i,j+1)-x2(i,j+1)/del;
Hdel_l=stageH(x2,f,j);
Mdel_l=stageM(x2,f,j);
Edel_l=stageE(x2,j);
dhdi(i)=(Hdel_u-Hdel_l)/(2*xpart(i,j+1)/del);
dmdi(:,i)=(Mdel_u-Mdel_l)/(2*xpart(i,j+1)/del);
dedi(:,i)=(Edel_u-Edel_l)/(2*xpart(i,j+1)/del);
end

C = vertcat(dhdi,dmdi,dedi);  

end
end

