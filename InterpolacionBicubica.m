pkg load image
#Probando con una imgen en mala calidad y bajando aún más la calidad
#Leemos la imagen pasandola a una matriz de pixeles
imagen = imread("beteese.jpeg");
#Colocamos una escala de grises ya que si se hace a color se tendría que hacer una interpolación por cada intensidad de color en rgb
imagen=rgb2gray(imagen);
#Bajamos aún más la calidad de la imagen
imagenmc=imresize(imagen,0.05);
figure;
#Mostramos una matriz donde al manipularla podremos ver la imagen
imagesc(imagenmc);
#Coloca la imagen a escala de grises al momento de mostrarla ya que de no ser así Octave interpreta la matriz de pixeles como intensidad de colores
colormap(gray);
#Mantiene el tamaño de los pixeles originales de no ser así forzara en colocar la imagen en el tamaño completo de la venta de la pantalla
daspect([1 1]);
imagenec = uint8(round(bicubicaEscala(double(imagenmc), 2)));
figure;
imagesc(imagenec);
colormap(gray);
daspect([1 1]);
