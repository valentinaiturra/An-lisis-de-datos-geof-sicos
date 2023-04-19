clc
clear all
close all

A = readmatrix('imaunaloaNaN.dat.dat');
[fila,columna] = find(A == -9999);
tamano=length(columna);

%Para reemplazar por NaN
for i=1:tamano
    A(fila(i),columna(i)) = NaN;
end

%Para las dos columnas
B= [];
n = 0;
years=A(:,1);

for j=1:66
    for i=1:12
        n=n+1;
        B(n,2)=A(j,(i+1));
    end
end
count=0;
for j=1958:2023
    for i=1:12
        count=count+1;
        B(count,1) = j + [i/12-1/24];
    end
end

%GUIA 3

aa = ~isnan(B(:,2));
idx = find(aa == 0);
B2 = B;
B2(idx,:) = [];

%ITEM 1

x = B(:,1);
y = B(:,2);
pp1 = polyfit(x,y,1);
pv1 = polyval(pp1,x); 

Error1= pv1 - y;

%ITEM 2
p2 = polyfit(x,y,2);
pv2 = polyval(p2,x);

Error2 = pv2 -y;

%ITEM 3

figure()
plot(x,y,'-b')
hold on
plot(x,pv1,'-r')
legend('Datos totales','Regresion de 1er grado')

figure ()
plot(x,y,'-b')
hold on
plot(x,pv2,'-m')
legend('Datos totales','Regresion de 2er grado')

ITEM 4

1 grado
figure()
    subplot (3,1,1)
        plot(x,y,'-b')
        hold on
        plot(x,pv1,'-r')
    subplot(3,1,2)
        plot(x,Error1,'-r')
    subplot(3,1,3)
        bar(Error1)

%2do grado
figure()
    subplot (3,1,1)
        plot(x,y,'-b')
        hold on
        plot(x,pv2,'-r')
    subplot(3,1,2)
        plot(x,Error2,'-r')
    subplot(3,1,3)
        bar(Error2)

%ITEM 5
load ICE.mat

a = ~isnan(ICE(:,2));
idxx = find(a == 0);
ICE2=ICE;
ICE2(idxx,:) = [];

x = ICE2(:,1);
v = ICE2(:,2);
xq = ICE(:,1);

p = interp1(x,v,xq,'spline');

%item 6
figure()
plot(ICE(:,1),p,'-.r')
hold on
plot(ICE(:,1),ICE(:,2),'b')
legend('Datos interpolados','Datos totales')

% %ITEM 8
% xx = B2(:,1);
% vv = B2(:,2);
% xqq = B(:,1);
% 
% pp(:,1) = B(:,2);
% pp(:,2) = interp1(xx,vv,xqq,'linear');
% pp(:,3) = interp1(xx,vv,xqq,'nearest');
% pp(:,4) = interp1(xx,vv,xqq,'next');
% pp(:,5) = interp1(xx,vv,xqq,'previous');
% pp(:,6) = interp1(xx,vv,xqq,'spline');
% pp(:,7) = interp1(xx,vv,xqq,'pchip');
% %p7 = interp1(x1,v1,xq1,'cubic');
% %p8 = interp1(x1,v1,xq1,'v5cubic');
% pp(:,8) = interp1(xx,vv,xqq,'makima');
% 
% for i = 1:8
%     figure(1)
%         subplot(2,4,i)
%             plot(B(:,1),pp(:,i))
% end
% %ITEM 9
% 
% pp1(:,1) = ICE(:,2);
% pp1(:,2) = interp1(x,v,xq,'linear');
% pp1(:,3) = interp1(x,v,xq,'nearest');
% pp1(:,4) = interp1(x,v,xq,'next');
% pp1(:,5) = interp1(x,v,xq,'previous');
% pp1(:,6) = interp1(x,v,xq,'spline');
% pp1(:,7) = interp1(x,v,xq,'pchip');
% %p7 = interp1(x1,v1,xq1,'cubic');
% %p8 = interp1(x1,v1,xq1,'v5cubic');
% pp1(:,8) = interp1(x,v,xq,'makima');
% 
% for i = 1:8
%     figure(2)
%         subplot(2,4,i)
%             plot(ICE(:,1),pp1(:,i))
% end