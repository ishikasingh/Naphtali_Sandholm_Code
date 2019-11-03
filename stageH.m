
function [ H ] = stageH(X,f,j)
% to find H[j] for a given j(tray)
n=19;
r=9.5; B=62;
xv=X(1:5,:); xl=X(7:11,:);
sv=sum(xv); sl=sum(xl);
if j==1
H= sl(:,1)-(r/(r+1))*sv(:,1);
elseif j==19
H=sl(:,19)-B;

elseif j==7;

H=-sl(j-1)*hl(xl(:,j-1)./sl(j-1),X(6,j-1))-sv(j+1)*hv(xv(:,j+1)./sv(j+1),X(6,j+1))+sl(j)*hl(xl(:,j)./sl(j),X(6,j))+sv(j)*hv(xv(:,j)./sv(j),X(6,j));        

else
H=-sl(j-1)*hl(xl(:,j-1)./sl(j-1),X(6,j-1))-sv(j+1)*hv(xv(:,j+1)./sv(j+1),X(6,j+1))+sl(j)*hl(xl(:,j)./sl(j),X(6,j))+sv(j)*hv(xv(:,j)./sv(j),X(6,j));        
end

end

