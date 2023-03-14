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
count=0;
for j=1:66
    for i=1:12
        n=n+1;
        datos2(n,2)=datos(j,(i+1));
        count=count+1;
        datos2(count,1) = datenum(years(j),i,1);
    end
end
x=datos2(:,1);
y=datos2(:,2);
xi=datos2(1,1);
xf=datos2(end,1);

plot(x,y,'-r','LineWidth',2)
grid minor
xticks(xi:1000:xf)
datetick('x','yyyy','keeplimits')
title('Concentraciones de CO2 medidas en Mauna Loa')
ylabel('CO2 [ppm]')
xlabel('Años de medicion de la concentración')