score(Throw, Score):- Throw = "A", Score = 1.
score(Throw, Score):- Throw = "B", Score = 2.
score(Throw, Score):- Throw = "C", Score = 3.
score(Throw, Score):- Throw = "X", Score = 1.
score(Throw, Score):- Throw = "Y", Score = 2.
score(Throw, Score):- Throw = "Z", Score = 3.

wins(2, 1):- !.
wins(3, 2):- !.
wins(1, 3):- !.
wins(P1, P2):-
    is_alpha(P1), is_alpha(P2),
    score(P1, Score1),
    score(P2, Score2),
    wins(Score1, Score2).

result(P1, P2, Result):-
    wins(P1, P2), !,
    score(P1, Score),
    Result is Score + 6.
result(P1, P2, Result):-
    wins(P2, P1), !,
    score(P1, Result).
result(P1, _, Result):-
    score(P1, Score),
    Result is Score + 3.

solve([], Sol):- Sol = 0.
solve([H|T], Sol):- 
    solve(T, TotalT),
    split_string(H, " ", "", [Them, You]),
    result(You, Them, Result),
    format("~w ~w ~w~n", [Them, You, Result]),
    Sol is Result + TotalT.

read_file(Stream,[]):-
    at_end_of_stream(Stream).

read_file(Stream,[X|L]):-
    \+  at_end_of_stream(Stream),
    read_line_to_codes(Stream,Codes),
    atom_chars(X, Codes),
    read_file(Stream,L), !.

main:-
    open('cases/input/2', read, Stream),
    read_file(Stream, Input),
    solve(Input, Solution),
    print(Solution),
    close(Stream).

