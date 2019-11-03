
function [ M ] = stageM(X,f,j)
% to find M[1..c] for a given j(tray)
c=5; N=19; r=1/9.5;
if j==1 
for i=1:c
        M(i)=-X(i,1+1)-f(i,1)+(1+r)*X(c+1+i,1)+X(i,1);
end

elseif j==N
for i=1:c
        M(i)=-X(c+1+i,N-1)-f(i,N)+X(c+1+i,N)+X(i,N);
end

else
    for i=1:c
        M(i)=-X(c+1+i,j-1)-X(i,j+1)-f(i,j)+X(c+1+i,j)+X(i,j);
    end
end

end