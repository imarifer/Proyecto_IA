function [mu, varianza] = entrenarEM(datos)
  rho = 0.95; %El rho nos ayuda a decidir que tanto valor va a tener el resultado
  % pasado y el nuevo resultado. Con rho 99 le da el 95% del valor al pasado y 5 al promedio

  confianza = 200; %Que tan flexible es el grupo, si la distancia es menor a 200
  % es parte del grupo, si no, se crea un nuevo grupo. Podemos ajustar la confianza para
  % modificar la cantidad de grupos que se van a crear, mientras mas confianza menos grupos

  % Creamos los grupos de mu y varianza
  mu = [];
  varianza = [];

  for i=1:size(datos,1) % Recorre la cantidad de filas (cantidad de imagenes)

    muestra = datos(i,:); % Tomamos los datos de todas las columnas de una fila

    D = zeros(size(mu,1),1); %Creamos una matriz de (filas en mu) * 1 para guardar la
    % distancia que cada imagen tiene con cada grupo

    for j=1:size(mu,1) % Recorre todos los grupos que se han generado

      distancia = 0;

      for k=1:size(datos,2) %Recorre la cantidad de columnas de cada imagen (caracteristicas)
        distancia += ((muestra(k)-mu(j,k))^2) / varianza(j,k);
        % tomamos la muestra k la restamos al promedio que hay en mu y elevamos la cantidad
        % al cuadrado para evitar negativos y castigar distancias grandes y dividimos entre la varianza

      endfor

      D(j) = distancia; %Guardamos distancias

    endfor

    Dc = D <= confianza; % Generamos un vector de booleanos para ver que grupos cumplen

    if(sum(Dc)==0) %Si ningun grupo acepto la imagen

      mu = [mu; muestra]; %Se crea un nuevo grupo
      varianza = [varianza; ones(1,size(datos,2))*10];
      % Creamos el valor de la varianza de ese grupo

    else %Si pertenece a un grupo

      for j=1:size(Dc,1) %Se recorren todos los grupos

        if(Dc(j)==1) %Si acepta la imagen

          for k=1:size(datos,2)  %Por cada característica

            mu(j,k) = rho*mu(j,k) + (1-rho)*muestra(k); %Actualizamos el promedio

            varianza(j,k) = rho*varianza(j,k) + (1-rho)*(mu(j,k)-muestra(k))^2;
            %Si la imagen es muy diferente aumenta la varianza, si no lo es, disminuye

          endfor

        endif

      endfor

    endif

  endfor

endfunction
