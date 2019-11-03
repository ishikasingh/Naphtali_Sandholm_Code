function [ M ] = Mij(X,f) %Mij's
c=5; N=19; r=1/9.5;
%different equation for stage 1 and N
for i=1:c
        M(i,1)=-X(i,1+1)-f(i,1)+(1+r)*X(c+1+i,1)+X(i,1);
        M(i,N)=-X(c+1+i,N-1)-f(i,N)+X(c+1+i,N)+X(i,N);
end

for j=2:N-1
    for i=1:c
        M(i,j)=-X(c+1+i,j-1)-X(i,j+1)-f(i,j)+X(c+1+i,j)+X(i,j);
    end
end

end

