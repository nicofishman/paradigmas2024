:- use_module(paises).
:- use_module(ocupacion).

% sonLimitrofes(P1, P2) :- limita(P1, P2) ; limita(P2, P1).

sonLimitrofes(P1, P2) :- limita(P1, P2).
sonLimitrofes(P1, P2) :- limita(P2, P1).

% Que pais limita con un pais de otro continente

paisLimitrofeDeOtroContinente(Pais, OtroPais) :- 
  pais(Pais, Continente), 
  pais(OtroPais, OtroContinente), 
  Continente \= OtroContinente,
  sonLimitrofes(Pais, OtroPais).

% Predicado que me diga los enemigos de un país, es decir sus limítrofes que no tengan el mismo color.
enemigos(Pais) :-
  ocupa(Color, Pais, _),
  ocupa(OtroColor, OtroPais, _),
  Color \= OtroColor,
  sonLimitrofes(Pais, OtroPais),
  write(OtroPais).
  
% Predicado complicado/1 verifica si un país está "complicado", es decir, si tiene dos países limítrofes del mismo color y la suma de los ejércitos de ambos países es al menos 5.
complicado(Pais) :-
  ocupa(ColorPais, Pais, _),
  ocupa(Color, OtroPais1, Ejercitos1),
  ocupa(Color, OtroPais2, Ejercitos2),
  OtroPais1 \= OtroPais2,
  ColorPais \= Color,
  sonLimitrofes(Pais, OtroPais1),
  sonLimitrofes(Pais, OtroPais2),
  Ejercitos1 + Ejercitos2 >= 5.


% Predicado puede_atacar/1 que determine si un país tiene más ejércitos que uno de sus países limítrofes que sea de otro color.
puede_atacar(Pais) :-
  ocupa(ColorPais, Pais, Ejercitos),
  ocupa(Color, OtroPais, OtroEjercitos),
  ColorPais \= Color,
  sonLimitrofes(Pais, OtroPais),
  Ejercitos > OtroEjercitos.

% Un ejercito esFuerte/1 si ninguno de sus países está complicado.
esFuerte(Color) :-
  ocupa(Color, Pais, _),
  not(complicado(Pais)).
