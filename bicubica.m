function Z = bicubica(x, y, xs, ys, qs)
  #xs es el arreglo donde se encuentran los cuatro valores en x
  #ys es el arreglo donde se encuentran los cuatro valores en y
  #qs es la matriz donde se encuentran los 16 valores en z para cada punto (x,y)

  #Cantidad de iteraciones en el for que puede definir tantos valores de xs o ys que tangamos
  disp(xs);
  ni = length(xs);
  nj = length(ys);

  resultado_j = 0;
  resultado_i = 0;

  for i=1:ni
    disp("Validando que se ejecuten todas las veces");
    disp(i)
    resultado_j = 0;
    for j=1:nj
      disp("Ejecuciones en j");
      disp(j)
      #Vamos a ir obteniendo cada punto (x, y) dentro de todas sus combinaciones
      x_ = xs(i);
      disp("X_");
      disp(x_);
      y_ = ys(j);
      disp("Y_");
      disp(y_);
      #Obtenemos su valor correspondiente de z
      q_ = qs(i, j);
      disp("Q_");
      disp(q_);
      #Mandamos a llamar a la función Lx para calcular para cada punto
      lx_ = independiente(x, x_, xs);
      disp("LX_");
      disp(lx_);
      #Mandamos a llamar a la función Ly para calcular para cada punto
      ly_ = dependiente(y, y_, ys);
      disp("LY_");
      disp(ly_);
      resultado_j += q_ * lx_ * ly_;
      disp("resultadoJ");
      disp(resultado_j);
    endfor
    resultado_i += resultado_j;
  endfor
  disp("Probando el ultimo valor que obtiene resultado para Z");
  disp(resultado_i);
  Z = resultado_i;
endfunction
#Funcion que calcula el valor LX de acuerdo a la formula estipulada
function LX = independiente(x, x_, xs)
  mult_xs = 1;
  for i=1:length(xs)
    if(x_ != xs(i))
      mult_xs *= (x-xs(i))/(x_-xs(i));
    endif
  endfor
  LX = mult_xs;
endfunction
#Funcion que calcula el valor LY de acuerdo a la formula estipulada
function LY = dependiente(y, y_, ys)
  mult_ys = 1;
  for i=1:length(ys)
    if(y_ != ys(i))
      mult_ys *= (y-ys(i))/(y_-ys(i));
    endif
  endfor
  LY = mult_ys;
endfunction
