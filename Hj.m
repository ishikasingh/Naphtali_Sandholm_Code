
function [ H ] = Hj(X,f)
n=19;
H=zeros(1,n); r=9.5; B=62;
xv=X(1:5,:); xl=X(7:11,:);
sv=sum(xv); sl=sum(xl);

for j=2:18
H(j)=-sl(j-1)*hl(xl(:,j-1)./sl(j-1),X(6,j-1))-sv(j+1)*hv(xv(:,j+1)./sv(j+1),X(6,j+1))+sl(j)*hl(xl(:,j)./sl(j),X(6,j))+sv(j)*hv(xv(:,j)./sv(j),X(6,j));        
end

%replacement eqn for H1 and HN, since Q1 and QN not given
H(1)= sl(:,1)-(r/(r+1))*sv(:,1);
H(19)=sl(:,19)-B;


j=7;
H(j)=-sl(j-1)*hl(xl(:,j-1)./sl(j-1),X(6,j-1))-sv(j+1)*hv(xv(:,j+1)./sv(j+1),X(6,j+1))+sl(j)*hl(xl(:,j)./sl(j),X(6,j))+sv(j)*hv(xv(:,j)./sv(j),X(6,j));        
end

