%antoine params -- T(K), P(bar)
% comp 1-methanol, 2-acetone, 3-methyl acetate, 4-benzene, 5-chloroform
A=[5.20409 4.42448 4.20364 4.72583 4.20772];
B=[1581.341 1312.253 1164.426 1660.652 1233.129];
C=[-33.50 -32.445 -52.69 -1.461 -40.953];

% no. of components and stages
N=19; c=5;
F=zeros(1,N);
F(7)=100; %kmol/hr
z=[.15, .4, .05, .2, .2]; %feed
Tf=330; %K,liquid
Pf=1.013; %bar
P=1.013.*ones(1,N); %pressure at each stage

% T guess at each stage using linear interpolation
delT=(80.1-56)/(N-1);
T=ones(1,N); T(1)=56+273.15;
for i=2:19
    T(i)=T(i-1)+delT;
end

f=zeros(c,N); % feed matrix: f_i,j
f(:,7)=[15, 40, 5, 20, 20];
s=zeros(1,N); % 
s(1)=1/9.5; % D(=U1)/L1= 1/r

% phi calucated by assuming the entire distillation column as a flash drum,
% with V2 and B(=LN) in equilibrium 
phi=0.866; x=zeros(c,N); y=zeros(c,N); k=zeros(c,N);

% using this phi on Feed for finding vapour and liquid flow rates inside
% column (assumed same at every stage as the guess value)
V=phi*F(7); L=F(7)-V;
 
%using the phi value and ki (from Raoult's law) to find xi and yi (assumed same at each stage)
for i=1:c
    psat=(10^(A(i)-B(i)/(T(7)+C(i)))); %bar
    k(i)=psat/P(7);
    x(i,:)=(z(i))/((k(i)-1)*phi + 1);
    y(i,:)=k(i)*x(i,:);
end

%using xij's and yij's to find lij's and vij's
l=x.*L; v=y.*V;

%making the guess X vector
X=zeros(1,1);
xpart=zeros((2*c+1),N); %matrix form of X for easy computation
for j=1:N
    xpart(6,j)=T(j);
    for i=1:c
    xpart(i,j)=v(i,j);
    xpart(c+1+i,j)=l(i,j);
    end
    X=horzcat(X,xpart(:,j)'); % linearization
end
X=X(2:210); %vector form of X 



fpart=zeros((2*c+1),N); %matrix form of F

disp('The runtime is 2.5 min..')

%  the loop: Newton Raphson!!!!
lemda=hv(z,330); % vaporization enthalpy of feed at feed temperature (used for normalization of Hj in tau expression.
tau=4; epsilon=2; check=0;
while tau>epsilon



H=Hj(xpart,f); % returns Hj's
M=Mij(xpart,f); % Mij's
E=Eij(xpart); % Eij's

F=zeros(1,1);
for j=1:N
    fpart(1,j)=H(j);
    for i=1:c
    fpart(1+i,j)=M(i,j);
    fpart(1+c+i,j)=E(i,j);
    end
    F=horzcat(F,fpart(:,j)'); % linearization of F
end
F=F(2:210); %vector form of F

sz=2*c+1;
dFdX=zeros((sz)*N,(sz)*N); % DF/DX matrix

% DF/DX matrix, evaluated A, B, C matrices at each stage
for j=1:N
    if j==1
        [A1, B1, C1]=ABC(xpart,f,j);
        concat=horzcat(B1,C1);
        dFdX(1+sz*(j-1):sz*j,1:2*(sz))=concat;
    elseif j==N
        [A1, B1, C1]=ABC(xpart,f,j);
        concat=horzcat(A1,B1);
        dFdX(1+sz*(j-1):sz*j,(sz)*N+1-2*(sz):(sz)*N)=concat;
    else
        [A1, B1, C1]=ABC(xpart,f,j);
        concat=horzcat(A1,B1,C1);
        dFdX(1+sz*(j-1):sz*j,1+sz*(j-2):sz*(j+1))=concat;
    end
end

% Jacobian expression to find new X vector
Xnew=X'-inv(dFdX)*F';
X=Xnew';
for j=1:N
    xpart(:,j)=X(sz*(j-1)+1:sz*(j)); % making the matrix form of Xnew
end
epsilon=sz*N*(F*F')*10^(-10);
for j=1:N
    F(sz*(j-1)+1)= F(sz*(j-1)+1)/lemda;
end
tau=F*F';

check=check+1;
if check>=11
    break;
end
disp(check);
tau
epsilon
end

plotting(xpart);



