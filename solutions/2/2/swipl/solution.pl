result("A", "X", Result):- Result = 3.
result("A", "Y", Result):- Result = 4.
result("A", "Z", Result):- Result = 8.
result("B", "X", Result):- Result = 1.
result("B", "Y", Result):- Result = 5.
result("B", "Z", Result):- Result = 9.
result("C", "X", Result):- Result = 2.
result("C", "Y", Result):- Result = 6.
result("C", "Z", Result):- Result = 7.

solve([], Sol):- Sol = 0.
solve([H|T], Sol):- 
    solve(T, TotalT),
    split_string(H, " ", "", [P, Q]),
    result(P, Q, Result),
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

