str = input('Introduce el nombre del audio de formato wav que se desea analizar siguiendo el modelo nombreaudio.wav: ','s');
respuesta = findtones(str)

%Tonales: Mateo(alarma,telefono), Diego(ruido,corazon), Pablo (clock,pitidos)
%Carmela(piano,violines)
%No tonales: Mateo(arroyo,bus) Diego(trafico,avion) Carmela(puerta,pasos),
%Pablo(birds,demolicion)


