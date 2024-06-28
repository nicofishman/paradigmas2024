% destruir al ejército amarillo
% conquistar Asia
% conquistar Sudamérica y África
% conquistar Europa y dos países de Oceanía
% proponer un objetivo extra, que no sea ni de conquista ni de destrucción.
% (desafío) conquistar 50 países

:- use_module(paises).
:- use_module(ocupacion).
:- dynamic ocupa/3.
:- dynamic pais/2.

amarilloDestruido :-
  not(ocupa(amarillo, _, _)).

conquisto(E, Cont) :-
  pais(_, Cont),
  ocupa(E, _, _),
  forall(pais(P, Cont), ocupa(E, P, _)).

conquistoAsia(E) :- conquisto(E, asia).

conquistoSudamericaYAfrica(E) :-
  conquisto(E, sudamerica),
  conquisto(E, africa).

conquistoEuropaYDosPaisesDeOceania(C) :-
  conquisto(C, europa),
  findall(P, (pais(P, oceania), ocupa(C, P, _)), Paises),
  length(Paises, Cant),
  Cant >= 2.

ganoElJuego(C) :-
  amarilloDestruido,
  conquistoAsia(C),
  conquistoSudamericaYAfrica(C),
  conquistoEuropaYDosPaisesDeOceania(C).