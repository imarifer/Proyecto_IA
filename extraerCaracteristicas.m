function caracteristicas = extraerCaracteristicas(imagen)

  % Carga librería para poder trabajar con procesamiento de imagenes (imread, imsize...etc)
  pkg load image

  % Si la imagen esta a color (3 canales) la convertimos a escala de grises, esto
  % simplifica el análisis
  if(size(imagen,3)==3)
    imagen = rgb2gray(imagen);
  endif

  % Convertir a double para poder trabajar mejor con sus valores
  imagen = double(imagen);

  % CARACTERISTICA 1: calcula el promedio de todos los elementos de la matriz
  % para poder definir que tan clara u obscura es. Alto valor = claro, bajo = oscuro
  mediaIntensidad = mean(imagen(:));

  % CARACTERISTICA 2: Esto define que tanto varían los pixeles (desviación estandar),
  % para saber que tanto contraste tiene una imagen
  desviacion = std(imagen(:));

  % CARACTERÍSTICA 3: Edge detecta bordes, al final obtenemos la cantidad total de bordes
  % que hay para poder distinguir por ejemplo entre alas con muchas lineas o pocas lineas
  bordes = edge(uint8(imagen), 'canny');
  cantidadBordes = sum(bordes(:));

  % La entriopia mide que tan desordenada o compleja es una imagen, cantidad de info visual
  % (muchas texturas, tonos, patrones)
  entropiaImagen = entropy(uint8(imagen));

  % Vector final con las 4 características
  caracteristicas = [mediaIntensidad desviacion cantidadBordes entropiaImagen];

endfunction
