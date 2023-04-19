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

B(:,3)= detrend(B(:,2),'omitnan');
%Porque no calcula con el omitnan?
%si le quitas la tendencia se centran los datos

figure()
    subplot(2,2,1)
    histogram(B(:,2))
    title('Datos')
    
    subplot(2,2,2)
    histogram(B(:,3))
    title('Datos sin tendencia')

    subplot(2,2,3)
    histogram(B(:,2),'Normalization','probability')
    title('Datos Normalizados')

    subplot(2,2,4)
    histogram(B(:,3),'Normalization','probability')
    title('Datos Normalizados sin tendencia')

%Porque el histograma con y sin tendencia son distintos?
%con pendiente no hay sentido en la media,la grafica es homogenea, existe
%casi la misma cantidad de datos por intervalo en cambio en el otro no es
%asi, la distribucion de datos es diferente

%En cuanto a la parte normalizada, que corresponde al ajuste de los datos
%respecto a una escala comun

%Para determinar el rango intercuartil (IQR)
Q3 = prctile(B(:,2),75);
Q1 = prctile(B(:,2),25);
IQR = Q3 - Q1;
    %Otra forma es
    IQR = iqr(B(:,2));
    IQR2 = iqr(B(:,3));

%Ancho optimo
h = (2.6 * IQR)/(length(B(:,2)))^(1/3);
h2 = (2.6 * IQR2)/(length(B(:,3)))^(1/3);

%Graficos con en ancho optimo
figure()
    subplot(2,2,1)
    histogram(B(:,2),'BinWidth',h,'FaceColor','m')
    title('Datos')

    subplot(2,2,2)
    histogram(B(:,3),'BinWidth',h2,'FaceColor','m')
    title('Datos sin tendencia')

    subplot(2,2,3)
    histogram(B(:,2),'Normalization','probability','BinWidth',h,'FaceColor','m')
    title('Datos Normalizados')

    subplot(2,2,4)
    histogram(B(:,3),'Normalization','probability','BinWidth',h2,'FaceColor','m')
    title('Datos Normalizados sin tendencia')

%ITEM 5
meses = ["Enero","Febrero","Marzo","Abril","Mayo","Junio","Julio","Agosto","Septiembre","Octubre","Noviembre","Diciembre"];

for i=2:13
    mes(:,i-1) = A(:,i);
    IQR(i-1) = iqr(mes(:,i-1));
    h(i-1) = (2.6 * IQR(i-1))/(length(mes(:,i-1)))^(1/3);
    
    figure(3)
        subplot(3,4,i-1)
        histogram(mes(:,i-1),'BinWidth',h(i-1))
        title(meses(i-1))
end


%ITEM 6

%Para B(:,2)
media = mean(B(:,2),'omitnan');
mediana = median(B(:,2),'omitnan');

Q1 = prctile(B(:,2),25);
Q2 = prctile(B(:,2),50);
Q3 = prctile(B(:,2),75);
Q4 = prctile(B(:,2),100);

trimean = (Q1 + (2*Q2) + Q3)/4;
IQR = Q3 - Q1;
desviacion = std(B(:,2),'omitnan');

%Para B(:,3)
media_ = mean(B(:,3),'omitnan');
mediana_ = median(B(:,3),'omitnan');

Q1_ = prctile(B(:,3),25);
Q2_ = prctile(B(:,3),50);
Q3_ = prctile(B(:,3),75);
Q4_ = prctile(B(:,3),100);

trimean_ = (Q1_ + (2*Q2_) + Q3_)/4;

IQR_ = Q3_ - Q1_;
desviacion_ = std(B(:,3),'omitnan');

figure()
subplot (1,2,1)
    boxplot(B(:,2))
    hold on 
    plot(media,'r*')
    plot(trimean,'g*')
    plot(mediana,'m*')
    legend('Media','Trimean','Mediana')
    title('Datos')

subplot (1,2,2)
    boxplot(B(:,3))
    hold on 
    plot(media_,'r*')
    plot(trimean_,'g*')
    plot(mediana_,'m*')
    legend('Media','Trimean','Mediana')
    title('Datos sin tendencia')
%ITEM 8

for i=1:12
    figure(5)
    subplot (3,4,i)
    boxplot(mes(:,i))
    title(meses(i))

end