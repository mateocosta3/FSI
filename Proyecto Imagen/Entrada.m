clear all
close all
clc

fin = "Y";

imgsok = string([]);
imgsnok = imgsok;
pred_class = imgsnok;
known_class = pred_class;

i=1;

[manzana,mandarina,peras,fresas,platanos,kiwis,pinzas] = alfabetos('F01.jpg','F02.jpg','F03.jpg','F12.jpg','F10.jpg','F09.jpg','F25.jpg','F26.jpg','F27.jpg','F13.jpg','F18.jpg','F17.jpg','F19.jpg','F24.jpg','F22.jpg','F37.jpg','F38.jpg','F39.jpg','F31.jpg','F32.jpg','F33.jpg'); % Creamos todos los alfabetos de las distintas clases

while (fin == "Y")

    img = input('Introduce el nombre de la imagen de formato JPG que se desea analizar siguiendo el modelo nombreimagen.jpg: ','s');

    clase = input('Introduce  a la clase a la que pertenece la imagen seleccionada (manzana golden,mandarina,pera,fresa,platano,kiwi,pinza): ','s');
    known_class(i) = clase;
    
    [vec,og,maxc,masc,final] = identify_class(img); % Analizamos la imagen seleccionada
    
    figure;
    subplot(2,2,1);imshow(og);title('Imagen original');
    subplot(2,2,2);imshow(maxc);title('Imagen con mejora de color y enfoque');
    subplot(2,2,3);imshow(masc);title('Máscara');
    subplot(2,2,4);imshow(final);title('Máscara aplicada a la imagen');
    
    % Tarea 5: diseño de una funcion de reconocimiento
    
    dist_manz = manzana - vec;
    dist_mand = mandarina - vec;
    dist_per = peras - vec;
    dist_fre = fresas - vec;
    dist_plat = platanos - vec;
    dist_kiwi = kiwis - vec;
    dist_pinz = pinzas - vec;
    %HALLAMOS LA DISTANCIA MINIMA
    vector_dist = [norm(dist_manz) norm(dist_mand) norm(dist_per) norm(dist_fre) norm(dist_plat) norm(dist_kiwi) norm(dist_pinz)];
    [M,I] = min(vector_dist);
    
    
    switch I
        %CASO SUPUESTA MANZANA
        case 1 
           str = ['Clase: manzana golden']
           pred_class(i) = "manzana golden";
            if clase == "manzana golden"
                imgsok(i) = img;
            else
                imgsnok(i) = img;
            end
        
        %CASO SUPUESTA MANDARINA
        case 2
            str = ['Clase: mandarina']
            pred_class(i) = "mandarina";
            if clase == "mandarina"
                imgsok(i) = img;
            else
                imgsnok(i) = img;
            end
        
        %CASO SUPUESTA PERA
        case 3
            str = ['Clase: pera']
            pred_class(i) = "pera";
            if clase == "pera"
                imgsok(i) = img;
            else
                imgsnok(i) = img;          
            end
        
        %CASO SUPUESTA FRESA
        case 4
            str = ['Clase: fresa']
            pred_class(i) = "fresa";
            if clase == "fresa"
                imgsok(i) = img;
            else
                imgsnok(i) = img;  
            end

        %CASO SUPUESTO PLATANO
        case 5
            str = ['Clase: platano']
            pred_class(i) = "platano";
            if clase == "platano"
                imgsok(i) = img;
            else
                imgsnok(i) = img;
            end

        %CASO SUPUESTO KIWI
        case 6
            str = ['Clase: kiwi']
            pred_class(i) = "kiwi";
            if clase == "kiwi"
                imgsok(i) = img;
            else
                imgsnok(i) = img;
            end

        %CASO SUPUESTA PINZA
        case 7
            str = ['Clase: pinza']
            pred_class(i) = "pinza";
            if clase == "pinza"
                imgsok(i) = img;
            else
                imgsnok(i) = img;
            end
    end

    % Tarea 6: prueba

    figure % Mostramos la matriz de confusion en forma de imagen
    [C,order] = confusionmat(known_class,pred_class,'Order',["manzana golden" "mandarina" "fresa" "platano" "pera" "kiwi" "pinza"]);
    cm = confusionchart(C,order);
    
    fin = input('Desea analizar alguna otra imagen? (Y/N)','s');
    
    i = i + 1;

end

imgsok = rmmissing(imgsok);
imgsnok = rmmissing(imgsnok);

tasa_exito = (numel(imgsok)/(numel(imgsnok)+numel(imgsok)))*100;
tasa_error = (numel(imgsnok)/(numel(imgsnok)+numel(imgsok)))*100;

fprintf('\n\n\n\tRESULTADOS FINALES\n');
fprintf(['\n-Imágenes analizadas correctamente: ',repmat('%s, ',1,numel(imgsok)-1), '%s\n'],imgsok);
fprintf(['-Imágenes analizadas incorrectamente: ',repmat('%s, ',1,numel(imgsnok)-1),'%s\n'],imgsnok);
fprintf('-Tasa de éxito porcentual: %g\n',tasa_exito);
fprintf('-Tasa de error porcentual: %g\n',tasa_error);
