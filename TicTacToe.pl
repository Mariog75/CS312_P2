win(Board, Player):- rowwin(Board,Player).
win(Board, Player):- colwin(Board,Player).
win(Board, Player):- diagwin(Board,Player).

rowwin(Board, Player):- Board = [Player, Player, Player, _, _, _, _, _, _].
rowwin(Board, Player):- Board = [_, _, _, Player, Player, Player, _, _, _].
rowwin(Board, Player):- Board = [ _, _, _, _, _, _, Player, Player, Player].

colwin(Board, Player):- Board = [Player, _, _, Player, _, _, Player, _, _].
colwin(Board, Player):- Board = [_, Player, _, _, Player, _, _, Player, _].
colwin(Board, Player):- Board = [_, _, Player, _, _, Player, _, _, Player].

diagwin(Board, Player):- Board = [Player, _, _, _, Player, _, _, _, Player].
diagwin(Board, Player):- Board = [_, _, Player, _, Player, _, Player, _, _].

player_can_win(Board):- move(Board, x, NewBoard), win(NewBoard, x).

move([b,B,C,D,E,F,G,H,I], Player, [Player,B,C,D,E,F,G,H,I]).
move([A,b,C,D,E,F,G,H,I], Player, [A,Player,C,D,E,F,G,H,I]).
move([A,B,b,D,E,F,G,H,I], Player, [A,B,Player,D,E,F,G,H,I]).
move([A,B,C,b,E,F,G,H,I], Player, [A,B,C,Player,E,F,G,H,I]).
move([A,B,C,D,b,F,G,H,I], Player, [A,B,C,D,Player,F,G,H,I]).
move([A,B,C,D,E,b,G,H,I], Player, [A,B,C,D,E,Player,G,H,I]).
move([A,B,C,D,E,F,b,H,I], Player, [A,B,C,D,E,F,Player,H,I]).
move([A,B,C,D,E,F,G,b,I], Player, [A,B,C,D,E,F,G,Player,I]).
move([A,B,C,D,E,F,G,H,b], Player, [A,B,C,D,E,F,G,H,Player]).

cornermove([b,B,C,D,E,F,G,H,I], Player, [Player,B,C,D,E,F,G,H,I]).
cornermove([A,B,b,D,E,F,G,H,I], Player, [A,B,Player,D,E,F,G,H,I]).
cornermove([A,B,C,D,E,F,b,H,I], Player, [A,B,C,D,E,F,Player,H,I]).
cornermove([A,B,C,D,E,F,G,H,b], Player, [A,B,C,D,E,F,G,H,Player]).

xmove([b,B,C,D,E,F,G,H,I], 1, [x,B,C,D,E,F,G,H,I]).
xmove([A,b,C,D,E,F,G,H,I], 2, [A,x,C,D,E,F,G,H,I]).
xmove([A,B,b,D,E,F,G,H,I], 3, [A,B,x,D,E,F,G,H,I]).
xmove([A,B,C,b,E,F,G,H,I], 4, [A,B,C,x,E,F,G,H,I]).
xmove([A,B,C,D,b,F,G,H,I], 5, [A,B,C,D,x,F,G,H,I]).
xmove([A,B,C,D,E,b,G,H,I], 6, [A,B,C,D,E,x,G,H,I]).
xmove([A,B,C,D,E,F,b,H,I], 7, [A,B,C,D,E,F,x,H,I]).
xmove([A,B,C,D,E,F,G,b,I], 8, [A,B,C,D,E,F,G,x,I]).
xmove([A,B,C,D,E,F,G,H,b], 9, [A,B,C,D,E,F,G,H,x]).
xmove(Board, N, Board) :- write('Please pick numbers 1-9'), nl.

pcmovehard(Board, NewBoard):-
  move(Board, o, NewBoard),
  win(NewBoard, o),
  !.
pcmovehard(Board, NewBoard):-
  move(Board, o, NewBoard),
  not(player_can_win(NewBoard)).
pcmovehard(Board, NewBoard):-
  move(Board, o, NewBoard).
pcmovehard(Board, NewBoard):-
  not(member(b, Board)),
  !,
  write('Draw!'), nl,
  NewBoard = Board.

pcmoveeasy(Board, NewBoard):-
  move(Board, o, NewBoard).
pcmoveeasy(Board, NewBoard):-
  not(member(b, Board)),
  !,
  write('Draw!'), nl,
  NewBoard = Board.



displayboard([A,B,C,D,E,F,G,H,I]):- write([A,B,C]),nl,write([D,E,F]),nl,write([G,H,I]),nl, nl.


playhard:- explain, playfromhard([b,b,b,b,b,b,b,b,b]).

playeasy:- explain, playfromeasy([b,b,b,b,b,b,b,b,b]).

explain:-
  write('Please use numbers 1-9 to pick where to move'), nl,
  displayboard([1,2,3,4,5,6,7,8,9]).


playfromeasy(Board):-win(Board, x), write('You win!').
playfromeasy(Board):-win(Board, o), write('I win!').
playfromeasy(Board):- read(N),
  xmove(Board, N, NewBoard),
  displayboard(NewBoard),
  pcmoveeasy(NewBoard, NewerBoard),
  displayboard(NewerBoard),
  playfromhard(NewerBoard).

playfromhard(Board):-win(Board, x), write('You win!').
playfromhard(Board):-win(Board, o), write('I win!').
playfromhard(Board):- read(N),
  xmove(Board, N, NewBoard),
  displayboard(NewBoard),
  pcmovehard(NewBoard, NewerBoard),
  displayboard(NewerBoard),
  playfromhard(NewerBoard).
