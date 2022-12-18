
main([]) -> 
  {ok, FileNames} = file:list_dir("cases/input"),
  lists:foreach(
      fun(FileName) -> 
        io:fwrite("~nOutput for case ~s~n", [FileName]),
        solvefile(FileName)
      end, FileNames).

readlines(FileName) ->
  {ok, Binary} = file:read_file(FileName),
  string:tokens(erlang:binary_to_list(Binary), "\n").

solvefile(FileName) ->
  Path = filename:join("cases/input", FileName),
  Lines = readlines(Path),
  solve(Lines).

solve(Lines) -> solve(Lines, 1, 1).
solve([], _, _) -> io:fwrite("~n");
solve([ Next | Rest ], X, Cycle) when Next == "noop" -> 
  output(X, Cycle),
  solve(Rest, X, Cycle+1);
solve([ Next | Rest ], X, Cycle) -> 
  output(X, Cycle),
  output(X, Cycle+1),
  N = list_to_integer(lists:last(string:split(Next, " "))),
  solve(Rest, X + N, Cycle+2).

output(X, Cycle) ->
  P = ((Cycle-1) rem 40),
  if 
    P == 0 -> io:fwrite("~n");
    true -> io:fwrite("")
  end,
  if 
    (P == X) or (P == X - 1) or (P == X + 1) -> 
      io:fwrite("#");
    true ->
      io:fwrite(".")
  end.
