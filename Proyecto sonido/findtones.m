
function [respuesta] = findtones(nombreaudio)

[audio,fs]= audioread(nombreaudio);
info = audioinfo(nombreaudio);
audio = audio(:,1);
[mfss,fHz] = ver_espectro(audio,'hamming',2048,fs);

media = mean(20*log10(mfss));

[~,locs] = findpeaks(20*log10(mfss),fHz,'minpeakheight',media + 15);

distmedia = mean(diff(locs));

[peaks,locs] = findpeaks(20*log10(mfss),fHz,'minpeakheight',media + 15,'minpeakdistance',distmedia/2,'MinPeakProminence',20);

hold on
l = length(mfss);
xlim([0,fs/2])
ylim([20*log10(mfss(l-1)),max(20*log10(mfss))+5])
plot(locs,peaks,'x')
hold off
%Valor de los picos
tonos = peaks;
%LOCALIZACIÓN DE LOS PICOS
frectonos = locs;

mediapicos = mean(peaks);
dif = mediapicos - media;

figure
spectrogram(audio,hamming(2048),0,2048,fs,'yaxis')

if dif > 27
    
    if isempty(tonos) || length(tonos) == 1
        respuesta = 'FALSO';
    else
        respuesta = 'VERDADERO';
        str = ['Información general de: ',nombreaudio,char(13),'    -Duración: ',num2str(info.Duration),' segundos',char(13),'    -Frecuencia de muestreo: ',num2str(info.SampleRate),' Hz',char(13),'    -Muestras totales: ',num2str(info.TotalSamples),char(13),'    -Número de bits por muestra: ',num2str(info.BitsPerSample),char(13),'    -Número de componentes tonales detectados: ',num2str(length(tonos)),char(13),'    -Magnitud máxima: ',num2str(max(tonos)),' dB']
        str = ['Información de cada tono: ']

        for i = 1:length(tonos)
            infotono = ['-Magnitud tono ',num2str(i),': ',num2str(tonos(i)),' dB',char(13),'-Frecuencia correspondiente: ',num2str(frectonos(i)),' Hz']
        end
    end
else
    respuesta = 'FALSO';
end

