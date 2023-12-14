-module(solve).
  -export([solve_part_one/0]).

solve_part_one() ->
  ok, Input = read_input(),

  Lines = string:lexemes(Input, "\n"),
  p(Lines),

  Pieces = lists:map(fun(Line) -> string:lexemes(Line, " ") end, Lines),
  XXX = lists:map(fun([L, R]) ->
    variations(L, R)
  end, Pieces),
  YYY = lists:map(fun(X) ->
    length(X)
  end, XXX),
  p(lists:foldl(
    fun(X, Sum) -> X+Sum end,
    0,
    YYY
  )),
  p("").

read_input() ->
  %{ok, Contents} = file:read_file("./input"), Contents.
  %{ok, Contents} = file:read_file("./example-x"), Contents.
  {ok, Contents} = file:read_file("./example"), Contents.

p(Val) when is_bitstring(Val) -> io:fwrite(Val), io:nl();
p(Val) -> io:format("~p", [Val]), io:nl().

variations(L, R) ->
  ProvidedDescription = lists:map(
    fun(In) -> {Out,_} = string:to_integer(In), Out end,
    string:lexemes(R, ",")
  ),

  {ok, Re1} = re:compile("(\\?|\\?[\\.#]*)"),
  Split  = re:replace(L, Re1, "_", [global]),
  LAfter = re:replace(L, "\\?", "", [global]),

  QCount = string:length(L) - string:length(LAfter),
  p("xxx----perms-----xxx"),
   Permutations = permutations(QCount),
  p(length(Permutations)),
  PossibleLandscapes = lists:map(
    fun(Permutation) -> apply_potential(L, Permutation) end,
    Permutations
  ),

  Valid = lists:filter(
    fun(Landscape) ->
      eq(ProvidedDescription, describe_map(Landscape))
    end,
    PossibleLandscapes
  ),
  p("x-----valid--------x"),
  p(length(Valid)),
  Valid.

permutations(Size) ->
  lists:map(
    fun(Mask) ->
      lists:map(
        fun(Bool) -> toggle(Bool, ".", "#") end,
        Mask
      )
    end,
    bit_masks(Size)
  ).


apply_potential(LandscapeWithQs, [X]) ->
  apply_potential(re:replace(LandscapeWithQs, "\\?", X));
apply_potential(LandscapeWithQs, [X|Rest]) ->
  apply_potential(re:replace(LandscapeWithQs, "\\?", X), Rest).

apply_potential(LandscapeWithoutQs) ->
  list_to_binary(LandscapeWithoutQs).

toggle(0, Str0, _Str1) -> Str0;
toggle(1, _Str0, Str1) -> Str1.


% e.g.
% ..#.#..###.. -> [1,1,3]
% ..#.#....... -> [1,1]
describe_map(Landscape) ->
  lists:map(fun(Str) -> string:len(Str) end, string:lexemes(binary_to_list(Landscape), "."))
  .

eq(Expected, Actual) when Expected =:= Actual -> true;
eq(_Expected, _Actual) -> false.


% blatently copied from http://blog.sethladd.com/2007/08/calculating-combinations-erlang-way.html
bit_masks(NumColumns) ->
  bit_masks(0, round(math:pow(2, NumColumns))-1, NumColumns).
bit_masks(Max, Max, NumColumns) ->
  [padl(NumColumns, bl(Max))];
bit_masks(X, Max, NumColumns) ->
  [padl(NumColumns, bl(X)) | bit_masks(X+1, Max, NumColumns)].

padl(N, L) when N =:= length(L) -> L ;
padl(N, L) when N > length(L) -> padl(N, [0|L]).

bl(N) -> bl(N, []).
bl(0, Accum) -> Accum;
bl(N, Accum) -> bl(N bsr 1, [(N band 1) | Accum]).
