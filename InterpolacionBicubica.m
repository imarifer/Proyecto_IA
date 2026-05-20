#Probando con una imgen en mala calidad y bajando aún más la calidad
#Leemos la imagen pasandola a una matriz de pixeles
%%imagen = imread("beteese.jpeg");
#Colocamos una escala de grises ya que si se hace a color se tendría que hacer una interpolación por cada intensidad de color en rgb
%%imagen=rgb2gray(imagen);
#Bajamos aún más la calidad de la imagen
%%imagenmc=imresize(imagen,0.05);
%%figure;
#Mostramos una matriz donde al manipularla podremos ver la imagen
%%imagesc(imagenmc);
#Coloca la imagen a escala de grises al momento de mostrarla ya que de no ser así Octave interpreta la matriz de pixeles como intensidad de colores
%%colormap(gray);
#Mantiene el tamaño de los pixeles originales de no ser así forzara en colocar la imagen en el tamaño completo de la venta de la pantalla
%%daspect([1 1]);
%%imagenec = uint8(round(bicubicaEscala(double(imagenmc), 2)));
%%figure;
%%imagesc(imagenec);
%%colormap(gray);
%%daspect([1 1]);

#Implementación para escalar las imagenes manteniendolas a color
#Se debe aplicar la interpolación para cada canal de color en el RGB de la forma en como se hizo con el canal de grises para la imagen en escala de grises

#Obtenemos cada uno de los canales de los rgb de la imagen
pkg load image

#Leemos la imagen pasandola a una matriz de pixeles
imagen = imread("beteese.jpeg");
#Bajamos aún más la calidad de la imagen
imagenmc=imresize(imagen,0.05);
figure;
#Mostramos una matriz donde al manipularla podremos ver la imagen
imagesc(imagenmc);
#Mantiene el tamaño de los pixeles originales de no ser así forzara en colocar la imagen en el tamaño completo de la venta de la pantalla
daspect([1 1]);
#Para el canal del color rojo
#Trabajamos con los valores de 0 a 255 a una escala del 0 a 1
r=double(imagenmc(:,:,1))/255;
#Para el canal del color verde
g=double(imagenmc(:,:,2))/255;
#Para el canal del color azul
b=double(imagenmc(:,:,3))/255;

#Interpolaciones para cada canal del color rgb
#Nos aseguramos que no se salga del rango de 0 a 1 que es el equivalente de 0 a 255
r_new=bicubicaEscala(r,2);
r_new=max(0,min(1,r_new));
g_new=bicubicaEscala(g,2);
g_new=max(0,min(1,g_new));
b_new=bicubicaEscala(b,2);
b_new=max(0,min(1,b_new));

#Primero volvemos a los valores originales de 0 a 255
#Para convertir de double a uint8 para que se pueda visualizar la imagen
r_new=uint8(round(r_new*255));
g_new=uint8(round(g_new*255));
b_new=uint8(round(b_new*255));

#Volvemos a agrupar cada canal de color del rgb
imgagenes=cat(3, r_new, g_new, b_new);
figure;
#Mostramos la imagen escalada
imagesc(imgagenes);
daspect([1 1]);





