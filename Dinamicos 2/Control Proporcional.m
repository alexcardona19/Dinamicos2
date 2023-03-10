clear all
close all

a=zeros(200,200); %%matriz

imshow(a)
g=9.8;
b= 0.43;
v(1)=0;
KP = 0.05; % ganancia proporcional del controlador proporcional

densidad_agua=1000;   %en kg/mt^3
prof_actual=0;
volumen= 1;   %en mt^3

prof_deseada = 75;


tm=0.5;  % "tiempo muerto" o "dead time" El tiempo muerto es el tiempo que transcurre
%desde que se emite una señal de control hasta que se produce una respuesta en el sistema controlado.


for i = 1:50 %i es el espacio que recorro en el eje y

  buoyant_force(i)=-(densidad_agua*g*volumen);

  v(i+1)=(buoyant_force(i) + (g-b*v(i)))*tm + v(i);
  prof_actual(i+1)=prof_actual(i)+v(i+1);


  error_posicion = -prof_deseada + prof_actual(i+1);
  volumen = KP*error_posicion+0.02;

    if(volumen<0)
    volumen=0;
    endif

  if(prof_actual(i+1)>=200)
    v(i+1)=-0.7*v(i);
    prof_actual(i+1)=200;
  end

   if(prof_actual(i+1)<=30)
    v(i+1)=-0.7*v(i);
    prof_actual(i+1)=29;

  end
  a(floor(prof_actual(i+1)),100)=255; %%100 es la fila

  imshow(a);
  a(floor(prof_actual(i+1)),100)=0;
  pause(0.0001);
endfor

plot(prof_actual)
ylabel('Posición (m)');
