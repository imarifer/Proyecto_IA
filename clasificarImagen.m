function grupo = clasificarImagen(caracteristicas, mu, varianza)
  %Le damos los datos de la imagen y de cada grupo con sus centros y varianzas

  confianza = 200; %Limite máximo permitido de distancia, si lo sobrepasa, no pertenece

  D = zeros(size(mu,1),1); %Crea un vector para guardar distancias con cada grupo

  for j=1:size(mu,1) % Recorremos cada grupo

    distancia = 0;

    for k=1:size(caracteristicas,2) %Recorremos cada caracteristica

      distancia += ((caracteristicas(k)-mu(j,k))^2) / varianza(j,k);
      %Diferencia de la imagen con el grupo

    endfor

    D(j) = distancia; %Guardamos la distancia total con el grupo

  endfor

  [valorMinimo, indice] = min(D); %Dentro de un arreglo min nos da el valor minimo
  % y el indice que lo identifica

  if(valorMinimo <= confianza) % Si el grupo al que mas se acerca no sobrepasa el
  % nivel de confianza, entonces lo acepta dentro del grupo
    grupo = indice;
  else
    grupo = -1; %Si todos los grupos sobrepasan el nivel de confianza no esta dentro de ninguno
  endif

endfunction
