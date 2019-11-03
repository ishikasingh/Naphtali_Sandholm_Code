function [] = plotting( xpart )
figure(1)
N1=1:1:19; xpart(6,:)=xpart(6,:)+20;%-273.15;
plot(N1,xpart(6,:),'-dg')
hold on
title('Temperature profile')
ylabel('T(oC)')
xlim([1 19])
xlabel('Stage')
hold off

figure(2)
xv=xpart(1:5,:); xl=xpart(7:11,:);
sv=sum(xv); sl=sum(xl);
for j=1:19
yfinal(:,j)=xv(:,j)./sv(j); xfinal(:,j)=xl(:,j)./sl(j);
end

plot(N1,yfinal(1,:),'-*r')
hold on
plot(N1,xfinal(1,:),'-*b')
plot(N1,yfinal(2,:),'-or')
plot(N1,xfinal(2,:),'-ob')
plot(N1,yfinal(3,:),'-sr')
plot(N1,xfinal(3,:),'-sb')
plot(N1,yfinal(4,:),'-+r')
plot(N1,xfinal(4,:),'-+b')
plot(N1,yfinal(5,:),'-xr')
plot(N1,xfinal(5,:),'-xb')
title('Composition at each stage')
ylabel('x,y')
xlabel('Stage')
legend('Methanol-vap comp', 'Methanol-liq comp','Acetone-vap comp','Acetone-liq comp','Methyl Acetate-vap comp','Methyl Acetate-liq comp','Benzene-vap comp','Benzene-liq comp','Chloroform-vap comp','Chloroform-liq comp')
legend('Location','northeastoutside')
hold off
end