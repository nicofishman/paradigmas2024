/*
Punto 1: Acciones del partido
Conocemos el nombre de cada jugador y las acciones que fueron pasando en el partido.
Las cuales son:
el dibu hizo una atajada en el minuto 122. También, en la tanda de penales atajó 2 de ellos.
messi metió 2 goles, uno en el minuto 108 de jugada y otro en el minuto 23 de penal. A su vez, también metió el primer penal de la tanda.
montiel metió el último penal de la tanda de penales.
Se pide modelar la base de conocimientos con las acciones y quienes las realizaron.

Punto 2: Puntajes de las acciones
Queremos saber cuantos puntos suma cada acción. Los cuales son calculados de la siguiente forma:
Para las atajadas tanda de penales, suman 15 * la cantidad que se hayan atajado
Para las otras atajadas, el puntaje se calcula como el minuto en el que ocurrió más 10
Para los goles, se calcula como el minuto en el que se metió más 20
Por último, para los penales que se metieron, en caso de que sea el primero suma  45 puntos mientras que si es el último suma 80 puntos
También, queremos saber cuantos puntos suma cada jugador. Es necesario que este predicado sea inversible.

Punto 3: Puntaje total
Dada una lista de jugadores, queremos saber cuantos puntos sumaron todos
*/

% Punto 1
accion(dibu, atajada(122)).
accion(dibu, atajada_penal_tanda(2)).
accion(messi, gol(108)).
accion(messi, gol(23)).
accion(messi, gol_penal_tanda(1)).
accion(montiel, gol_penal_tanda(5)).

% Punto 2
puntos(accion(_, atajada(Minuto)), Puntos) :-
  Puntos is Minuto + 10.
puntos(accion(_, atajada_penal_tanda(Cantidad)), Puntos) :-
  Puntos is 15 * Cantidad.
puntos(accion(_, gol(Minuto)), Puntos) :-
  Puntos is Minuto + 20.
puntos(accion(_, gol_penal_tanda(1)), 45).
puntos(accion(_, gol_penal_tanda(5)), 80).

puntos_jugador(Jugador, Puntos) :-
  findall(
    PuntosAccion, 
    (
      accion(Jugador, Accion), 
      puntos(accion(Jugador, Accion), PuntosAccion)
    ), 
    PuntosAcciones
    ),
  sum_list(PuntosAcciones, Puntos).

% Punto 3
puntos_totales(Jugadores, PuntosTotales):-
  findall(
    PuntosJugador, 
    (
      member(Jugador, Jugadores), 
      puntos_jugador(Jugador, PuntosJugador)
    ), 
    PuntosJugadores
  ),
  sum_list(PuntosJugadores, PuntosTotales).