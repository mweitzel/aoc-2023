-module(gleam@pair).
-compile([no_auto_import, nowarn_unused_vars, nowarn_unused_function]).

-export([first/1, second/1, swap/1, map_first/2, map_second/2, new/2]).

-spec first({GB, any()}) -> GB.
first(Pair) ->
    {A, _} = Pair,
    A.

-spec second({any(), GE}) -> GE.
second(Pair) ->
    {_, A} = Pair,
    A.

-spec swap({GF, GG}) -> {GG, GF}.
swap(Pair) ->
    {A, B} = Pair,
    {B, A}.

-spec map_first({GH, GI}, fun((GH) -> GJ)) -> {GJ, GI}.
map_first(Pair, Fun) ->
    {A, B} = Pair,
    {Fun(A), B}.

-spec map_second({GK, GL}, fun((GL) -> GM)) -> {GK, GM}.
map_second(Pair, Fun) ->
    {A, B} = Pair,
    {A, Fun(B)}.

-spec new(GN, GO) -> {GN, GO}.
new(First, Second) ->
    {First, Second}.
