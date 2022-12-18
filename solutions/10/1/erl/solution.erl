
main([]) -> 
  {ok, FileNames} = file:list_dir("cases/input"),
  lists:foreach(
      fun(FileName) -> 
        Solution = solvefile(FileName),
        io:fwrite("~nOutput for case ~s~n", [FileName]),
        io:fwrite("    ~B~n", [Solution]),
        {Pass, Expected} = checksolution(FileName, Solution),
        if
          Pass ->
            io:fwrite("pass~n");
          true ->
            io:fwrite("Expected:~n"),
            io:fwrite("    ~B~n", [Expected])
        end
      end, FileNames).

checksolution(FileName, Solution) ->
  Path = filename:join("cases/output", FileName),
  {ok, File} = file:open(Path, read),
  {ok, Line} = file:read_line(File),
  Expected = list_to_integer(string:strip(Line, right, $\n)),
  {Solution == Expected, Expected}.

readlines(FileName) ->
  {ok, Binary} = file:read_file(FileName),
  string:tokens(erlang:binary_to_list(Binary), "\n").

solvefile(FileName) ->
  Path = filename:join("cases/input", FileName),
  Lines = readlines(Path),
  solve(Lines).

solve(Lines) -> solve(Lines, 0, 1, 1).
solve([], Solution, _, _) -> Solution;
solve([ Next | Rest ], Solution, Total, Cycle) when Next == "noop" -> 
  io:fwrite("~B: noop, ~B, ~B~n", [Cycle, Total, Solution]),
  if 
    Cycle rem 40 == 20 -> 
      solve(Rest, Solution + (Cycle * Total), Total, Cycle+1);
    true ->
      solve(Rest, Solution, Total, Cycle+1)
  end;
solve([ Next | Rest ], Solution, Total, Cycle) -> 
  N = list_to_integer(lists:last(string:split(Next, " "))),
  io:fwrite("~B: addx, ~B, ~B~n", [Cycle, Total, Solution]),
  case Cycle rem 40 of 
    19 ->
      solve(Rest, Solution + ((Cycle+1) * Total), Total + N, Cycle+2);
    20 ->
      solve(Rest, Solution + (Cycle * Total), Total + N, Cycle+2);
    _ ->
      solve(Rest, Solution, Total + N, Cycle+2)
  end.

