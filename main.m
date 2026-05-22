% Limpiar consola, cerrar ventanas, imagenes, gráficas, variables anteriores
clc
close all
clear all

fprintf('EMPEZAMOS\n');
disp('=================================');

% Carga librería para poder trabajar con procesamiento de imagenes (imread, imsize...etc)
pkg load image

% Obtener todas las imagenes
archivos = dir('MUESTRAS/*.jpg');

baseDatos = []; % Se guardan las características numéricas de las imagenes
nombresImagenes = {}; % Se guardan los nombres de las imagenes

% Recorremos todas las imágenes
for i=1:length(archivos)

  nombre = archivos(i).name; % Guardamos el nombre

  ruta = strcat('MUESTRAS/', nombre); % Obtenemos la ruta

  imagen = imread(ruta); % Cargamos la imagen como matríz de números

  imagen = imresize(imagen,0.1); % Reducimos la calidad de la imagen
  % para mejorarla despues con interpolacion

  imagenInterpolada = imresize(imagen, 2, 'bicubic');
  % Tenemos archivos bicubica.m y bicubicaEscala.m, Fer los trabajó, es interpolación
  % bicubica desde cero. Para la demostración con el profe estoy usando la interpolación
  % que nos da imresize porque es mas optima y tarda mucho menos, pero hay que presentar la de
  % fer para explicar el concepto de interpolación bicubica

  % ======================================================================================
  % PRIMER CÓDIGO: EXTRAERCARATERISTICAS.M
  % ======================================================================================
  caracteristicas = extraerCaracteristicas(imagenInterpolada);
  %Creamos un arreglo con las cuatro características que estamos extrallendo
  %media=brillo promedio, desviación=contraste, bordes=cantidadDeBordes, entripía=complejidad

  fprintf('Caracteristicas imagen: ');
  disp(i);
  disp(caracteristicas);

  % Guardar características de las imagenes (las apilamos en filas)
  baseDatos = [baseDatos; caracteristicas];

  % Guardar nombre imagen
  nombresImagenes{i} = nombre;

endfor

disp('=================================');
disp('ENTRENANDO CLASIFICADOR EM');
disp('=================================');
% ======================================================================================
% SEGUNDO CODIGO: ENTRENAREM.M
% ======================================================================================
[mu, varianza] = entrenarEM(baseDatos);
% Se crean clusteres (grupos con valores parecidos)
% mu hace los "centros" (promedio) de cada grupo
% varianza mide que tanto varían las imagenes

for i=1:size(mu,1) %el ciclo va a ser de la cantidad del numero de filas en mu (grupos)

  fprintf('\nGRUPO %d\n', i);

  fprintf('Media Intensidad : %.2f\n', mu(i,1)); % (FILA,COLUMNA)
  fprintf('Desviacion       : %.2f\n', mu(i,2));
  fprintf('Cantidad Bordes  : %.2f\n', mu(i,3));
  fprintf('Entropia         : %.2f\n', mu(i,4));

endfor

disp('\n=================================');
disp('CLASIFICACION DE IMAGENES');
disp('=================================');

for i=1:size(baseDatos,1) %Cantidad de filas de la base de datos (todas las imagenes)
  % ======================================================================================
  % TERCER CODIGO: ENTRENAREM.M
  % ======================================================================================
  grupo = clasificarImagen(baseDatos(i,:), mu, varianza);
  % Le pasamos la fila i, todas sus columnas, todos los grupos del mu, que tan flexible
  % es cada grupo, asi sabe cuando permitir imagenes

  fprintf('%s ---> GRUPO %d\n', nombresImagenes{i}, grupo);

endfor

disp('\n=================================');
disp('PRUEBA CON NUEVA IMAGEN');
disp('=================================');

% Le el nombre ruta de la imagen a probar
rutaNueva = 'abejaMiel4.jpg';

if(exist(rutaNueva, 'file'))

  nueva = imread(rutaNueva);

  nueva = imresize(nueva,0.1);

  nuevaInterpolada = imresize(nueva,2,'bicubic');

  caracteristicasNueva = extraerCaracteristicas(nuevaInterpolada);
  fprintf('Caracteristicas imagen: \n');
  disp(caracteristicasNueva);

  grupoNuevo = clasificarImagen(caracteristicasNueva, mu, varianza);

  fprintf('\nResultado:\n');

  if(grupoNuevo == -1)

    disp('La imagen NO pertenece a ningun grupo conocido');

  else

    fprintf('La imagen pertenece al GRUPO %d\n', grupoNuevo);
    fprintf('\nGRUPO %d\n', grupoNuevo);

    fprintf('Media Intensidad : %.2f\n', mu(grupoNuevo,1));
    fprintf('Desviacion       : %.2f\n', mu(grupoNuevo,2));
    fprintf('Cantidad Bordes  : %.2f\n', mu(grupoNuevo,3));
    fprintf('Entropia         : %.2f\n', mu(grupoNuevo,4));

  endif

else

  disp('No existe prueba.jpg');

endif
