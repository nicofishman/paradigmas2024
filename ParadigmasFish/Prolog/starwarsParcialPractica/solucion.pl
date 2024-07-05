% https://docs.google.com/document/d/1UsI_VRMbrx-iFrCmJRQ7KMWDREgu0nZe4W_4zrkoPbU/edit

% El objetivo principal es deducir las principales características del próximo episodio. 
% En particular, se busca definir un predicado 
% nuevoEpisodio(Heroe, Villano, Extra, Dispositivo). 
% que permita relacionar a un personaje que sea el héroe del episodio con su correspondiente villano, junto con un personaje extra que le aporta mística y un dispositivo especial que resulta importante para la trama.

% Las condiciones que deben cumplirse simultáneamente son las siguientes:
% No se quiere innovar tanto, los personajes deben haber aparecido en alguno de los episodios anteriores y obviamente ser diferentes.
% Para mantener el espíritu clásico, el héroe tiene que ser un jedi (un maestro que estuvo alguna vez en el lado luminoso) que nunca se haya pasado al lado oscuro. 
% El villano debe haber estado en más de un episodio y tiene que mantener algún rasgo de ambigüedad, por lo que se debe garantizar que haya aparecido del lado luminoso en algún episodio y del lado oscuro en el mismo episodio o en un episodio posterior.  
% El extra tiene que ser un personaje de aspecto exótico para mantener la estética de la saga. Tiene que tener un vínculo estrecho con los protagonistas, que consiste en que haya estado junto al heroe o al villano en todos los episodios en los que dicho extra apareció. Se considera exótico a los robots que no tengan forma de esfera y a los seres de gran tamaño (mayor a 15) o de especie desconocida.
% El dispositivo tiene que ser reconocible por el público, por lo que tiene que ser un elemento que haya estado presente en muchos episodios (3 o más)

%apareceEn( Personaje, Episodio, Lado de la luz).
apareceEn( luke, elImperioContrataca, luminoso).
apareceEn( luke, unaNuevaEsperanza, luminoso).
apareceEn( vader, laVenganzaDeLosSith, luminoso).
apareceEn( vader, laAmenazaFantasma, luminoso).
apareceEn( vader, unaNuevaEsperanza, oscuro).
apareceEn( c3po, laAmenazaFantasma, luminoso).
apareceEn( c3po, unaNuevaEsperanza, luminoso).
apareceEn( c3po, elImperioContrataca, luminoso).
apareceEn( chewbacca, elImperioContrataca, luminoso).
apareceEn( yoda, elAtaqueDeLosClones, luminoso).
apareceEn( yoda, laAmenazaFantasma, luminoso).

%Maestro(Personaje)
maestro(luke).
maestro(leia).
maestro(vader).
maestro(yoda).
maestro(rey).
maestro(duku).

%caracterizacion(Personaje,Aspecto).
%aspectos:
% ser(Especie,Tamaño)
% humano
% robot(Forma)
caracterizacion(chewbacca,ser(wookiee,10)).
caracterizacion(luke,humano).
caracterizacion(vader,humano).
caracterizacion(yoda,ser(desconocido,5)).
caracterizacion(jabba,ser(hutt,20)).
caracterizacion(c3po,robot(humanoide)).
caracterizacion(bb8,robot(esfera)).
caracterizacion(r2d2,robot(secarropas)).

%elementosPresentes(Episodio, Dispositivos)
elementosPresentes(laAmenazaFantasma, [sableLaser]).
elementosPresentes(elAtaqueDeLosClones, [sableLaser, clon]).
elementosPresentes(laVenganzaDeLosSith, [sableLaser, mascara, estrellaMuerte]).
elementosPresentes(unaNuevaEsperanza, [estrellaMuerte, sableLaser, halconMilenario]).
elementosPresentes(elImperioContrataca, [mapaEstelar, estrellaMuerte] ).

precedeA(_,laAmenazaFantasma).
precedeA(laAmenazaFantasma,elAtaqueDeLosClones).
precedeA(elAtaqueDeLosClones,laVenganzaDeLosSith).
precedeA(laVenganzaDeLosSith,unaNuevaEsperanza).
precedeA(unaNuevaEsperanza,elImperioContrataca).

nuevoEpisodio(Heroe, Villano, Extra, Dispositivo):-
    apareceEn(Heroe, _, _),
    apareceEn(Villano, _, _),
    Heroe \= Villano,
    esJedi(Heroe),
    apareceEnMasDeUnEpisodio(Villano),
    esAmbiguo(Villano),
    esExotico(Extra),
    vinculoEstrecho(Extra, [Heroe, Villano]),
    dispositivoReconocible(Dispositivo).

esJedi(Heroe):-
    apareceEn(Heroe, _, luminoso),
    not(apareceEn(Heroe, _, oscuro)),
    maestro(Heroe).

apareceEnMasDeUnEpisodio(Personaje):-
    apareceEn(Personaje, Episodio1, _),
    apareceEn(Personaje, Episodio2, _),
    Episodio1 \= Episodio2.

% Aparece primero en un episodio como luminoso y en un episodio posterior como oscuro
esAmbiguo(Personaje):-
    apareceEn(Personaje, Episodio1, luminoso),
    apareceEn(Personaje, Episodio2, oscuro),
    esPosterior(Episodio1, Episodio2).

esPosterior(Episodio1, Episodio2):- % Ver casos que no son lineales, que tienen episodios en el medio
    precedeA(Episodio1, Episodio2).

noTieneFormaDeEsfera(Extra):-
    caracterizacion(Extra, robot(Forma)),
    Forma \= esfera.
granTamanio(Extra):-
    caracterizacion(Extra, ser(_, Tamanio)),
    Tamanio > 15.

esExotico(Extra):-
    noTieneFormaDeEsfera(Extra);
    granTamanio(Extra).

vinculoEstrecho(Extra, Personajes):-
    findall(
      Episodio, 
      (
        apareceEn(Extra, Episodio, _), 
        member(Personaje, Personajes), 
        apareceEn(Personaje, Episodio, _)
      ), 
      Episodios
    ),
    length(Episodios, CantidadEpisodios),
    CantidadEpisodios > 0.

dispositivoReconocible(Dispositivo):-
    findall(Episodio, (elementosPresentes(Episodio, Dispositivos), 
    member(Dispositivo, Dispositivos)
    ), Episodios),
    length(Episodios, CantidadEpisodios),
    CantidadEpisodios >= 3.

% 2. Encontrar todas las conformaciones posibles que se puedan armar. Mostrar ejemplos de consultas y respuestas.

todosLosPersonajes(Lista):- 
    findall(Personaje, apareceEn(Personaje, _, _), Lista).

todosLosDispositivos(Lista):-
    findall(Dispositivo, (elementosPresentes(_, Dispositivos), 
    member(Dispositivo, Dispositivos)
    ), Lista).

todasLasConformaciones(Lista):-
    todosLosPersonajes(Personajes),
    todosLosDispositivos(Dispositivos),
    findall(
      nuevoEpisodio(Heroe, Villano, Extra, Dispositivo), 
      (
        member(Heroe, Personajes), 
        member(Villano, Personajes), 
        Heroe \= Villano, 
        member(Dispositivo, Dispositivos), 
        esExotico(Extra), 
        vinculoEstrecho(Extra, [Heroe, Villano])
      ),
      Lista
      ).