
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

readlines(FileName) ->
  {ok, Binary} = file:read_file(FileName),
  string:tokens(erlang:binary_to_list(Binary), "\n").

solvefile(FileName) ->
  Path = filename:join("cases/input", FileName),
  Lines = readlines(Path),
  solve(Lines).

solve([_]) -> 0;
solve([ Prev, Next | Rest ]) when Next > Prev -> 1 + solve([ Next | Rest ]);
solve([ _, Next | Rest ]) -> 0 + solve([ Next | Rest ]).

checksolution(FileName, Solution) ->
  Path = filename:join("cases/output", FileName),
  {ok, File} = file:open(Path, read),
  {ok, Line} = file:read_line(File),
  Expected = list_to_integer(string:strip(Line, right, $\n)),
  {Solution == Expected, Expected}.

