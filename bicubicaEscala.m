function imgF = bicubicaEscala(img, escala)
  #Obtenemos el tamaño de la matriz de los pixeles de la imagen
  [h, w] = size(img);
  #Obtenemos el nuevo tamaño de la matriz de los pixeles de la imagen a la escala que se quiere lograr
  nh = round(h*escala);
  nw = round(w*escala);
  disp(nh);
  disp(nw);
  #Inicializamos matriz para los pixeles de la imagen escalada
  imgF = zeros(nh,nw);
  #Relación entre la imágen original y la imágen que se va a escalar
  #La equivalencia de 1 pixel en la original a cuantos pixeles equivale en la escalada
  re = (h-1)/(nh-1);
  ce = (w-1)/(nw-1);
  if(re != 0.5 && ce != 0.5)
    re = 0.5;
    ce = 0.5;
  endif
  #Recorremos cada pixel con valores en zeros de la matriz de la imagen resultante(nueva)
  for i=1:nh
    for j=1:nw
      #Obtenemos los vecinos que nos ayudaran a interpolar el nuevo valor
      x = (i-1)*re+1;
      y = (j-1)*re+1;
      x1 = floor(x);
      x2 = max(x1-1,1);
      x3 = min(x1+1,h);
      x4 = min(x3+1,h);
      y1 = floor(y);
      y2 = max(y1-1,1);
      y3 = min(y1+1,w);
      y4 = min(y3+1,w);
      disp(y1);
      disp(y2);

      #Obtenemos los puntos Qij, del peso en z para cada uno de los pares de valores x-y
      Q11 = img(x1,y1);
      Q12 = img(x1,y2);
      Q13 = img(x1,y3);
      Q14 = img(x1,y4);
      Q21 = img(x2,y1);
      Q22 = img(x2,y2);
      Q23 = img(x2,y3);
      Q24 = img(x2,y4);
      Q31 = img(x3,y1);
      Q32 = img(x3,y2);
      Q33 = img(x3,y3);
      Q34 = img(x3,y4);
      Q41 = img(x4,y1);
      Q42 = img(x4,y2);
      Q43 = img(x4,y3);
      Q44 = img(x4,y4);

      #Mandamos a llamar la función bicubica que nos dará los resultados del valor a interpolar
      imgF(i,j) = bicubica(x,y,[x1, x2, x3, x4],[y1, y2, y3, y4],[Q11, Q12, Q13, Q14; Q21, Q22, Q23, Q24; Q31, Q32, Q33, Q34; Q41, Q42, Q43, Q44]);
    endfor
  endfor
  endfunction
