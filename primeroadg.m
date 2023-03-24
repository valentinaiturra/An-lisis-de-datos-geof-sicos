clc
clear all
close all
datos = readmatrix("imaunaloaNaN.dat.dat");
[fila,columna] = find(datos== -9999);
tamano=length(columna);

%Para reemplazar por NaN
for i=1:tamano
    datos(fila(i),columna(i))=NaN;
end

%Para las dos columnas
datos2= [];
n=0;
years=datos(:,1);

for j=1:66
    for i=1:12
        n=n+1;
        datos2(n,2)=datos(j,(i+1));
    end
end
count=0;
for j=1958:2023
    for i=1:12
        count=count+1;
        datos2(count,1) = j + [i/12-1/24];
    end
end


x=datos2(:,1);
co2=datos2(:,2);

%MEDIA
media = nanmean(co2);
%DESVIACION
desviacion = nanstd(co2);
resta= media - desviacion;
suma = media + desviacion;
for i=1:792
    datos2(i,3)= media;
    datos2(i,4) = resta;
    datos2(i,5) = suma;
    datos2(i,6) = desviacion;
end

algo(:,1)= detrend(datos2(:,2),'omitnan');
pendiente= datos2(:,2)-algo(:,1);

algo(:,2) = nanmean(algo(:,1));
algo(:,3) = nanstd(algo(:,1)); %desviacion de estos nuevos datos detrend
algo(:,4) = algo(:,2) + algo(:,3); %suma
algo(:,5) = algo(:,2) - algo(:,3); %Resta

datos4(:,1) = movmean((datos2(:,2)),61,'omitnan'); %Mediamovil
datos4(:,2) = movstd(datos2(:,2),61,'omitnan'); %Desviacionmovil
datos4(:,3) = datos4(:,1) + datos4(:,2);
datos4(:,4) = datos4(:,1) - datos4(:,2);

%GRAFICO REAL
figure(1)
xi=datos2(1,1);
xf=datos2(end,1);
plot(x,co2,'-r','LineWidth',2)
grid minor
title('Concentraciones de CO2 medidas en Mauna Loa')
ylabel('CO2 [ppm]')
xlabel('Mmedicion de la concentración [años]')
xlim([1958,2023])
hold on
plot(x,datos2(:,4),'--g','LineWidth',2)
plot(x,datos2(:,5),'--y','LineWidth',2)
plot(x,datos2(:,3),'-m','LineWidth',2)
plot(x,pendiente,'-b','LineWidth',2)
legend('Datos','Suma media y desviacion','resta media y desviacion', 'Media','Pendiente')
hold off

figure(2)
plot(x,algo(:,1),'b','LineWidth',2)
hold on
plot(x,algo(:,4),'--g','LineWidth',2)
plot(x,algo(:,5),'--y','LineWidth',2)
plot(x,algo(:,2),'-m','LineWidth',2)
legend('Detrend','Suma desviacion y media','Resta desviacion y media', 'Media')
hold off

figure(3)
hold on
plot(x,co2,'-r','LineWidth',2)
plot(x,datos4(:,1),'-g','LineWidth',2)
plot(x,datos4(:,3),'--m','LineWidth',2)
plot(x,datos4(:,4),'--b','LineWidth',2)
legend('Datos', 'Media movil', 'Suma', 'Resta')
hold off
xlim([1958,2023])


