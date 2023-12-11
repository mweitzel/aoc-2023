-module(gleam@map).
-compile([no_auto_import, nowarn_unused_vars, nowarn_unused_function]).

-export([size/1, to_list/1, from_list/1, has_key/2, new/0, get/2, insert/3, map_values/2, keys/1, values/1, filter/2, take/2, merge/2, delete/2, drop/2, update/3, fold/3]).

-spec size(gleam@dict:dict(any(), any())) -> integer().
size(Map) ->
    gleam@dict:size(Map).

-spec to_list(gleam@dict:dict(EVG, EVH)) -> list({EVG, EVH}).
to_list(Map) ->
    gleam@dict:to_list(Map).

-spec from_list(list({EVJ, EVK})) -> gleam@dict:dict(EVJ, EVK).
from_list(List) ->
    gleam@dict:from_list(List).

-spec has_key(gleam@dict:dict(EVO, any()), EVO) -> boolean().
has_key(Map, Key) ->
    gleam@dict:has_key(Map, Key).

-spec new() -> gleam@dict:dict(any(), any()).
new() ->
    gleam@dict:new().

-spec get(gleam@dict:dict(EVR, EVS), EVR) -> {ok, EVS} | {error, nil}.
get(From, Get) ->
    gleam@dict:get(From, Get).

-spec insert(gleam@dict:dict(EVW, EVX), EVW, EVX) -> gleam@dict:dict(EVW, EVX).
insert(Map, Key, Value) ->
    gleam@dict:insert(Map, Key, Value).

-spec map_values(gleam@dict:dict(EWA, EWB), fun((EWA, EWB) -> EWC)) -> gleam@dict:dict(EWA, EWC).
map_values(Map, Fun) ->
    gleam@dict:map_values(Map, Fun).

-spec keys(gleam@dict:dict(EWF, any())) -> list(EWF).
keys(Map) ->
    gleam@dict:keys(Map).

-spec values(gleam@dict:dict(any(), EWI)) -> list(EWI).
values(Map) ->
    gleam@dict:values(Map).

-spec filter(gleam@dict:dict(EWL, EWM), fun((EWL, EWM) -> boolean())) -> gleam@dict:dict(EWL, EWM).
filter(Map, Predicate) ->
    gleam@dict:filter(Map, Predicate).

-spec take(gleam@dict:dict(EWP, EYJ), list(EWP)) -> gleam@dict:dict(EWP, EYJ).
take(Map, Desired_keys) ->
    gleam@dict:take(Map, Desired_keys).

-spec merge(gleam@dict:dict(EYK, EYL), gleam@dict:dict(EYK, EYL)) -> gleam@dict:dict(EYK, EYL).
merge(Map, New_entries) ->
    gleam@dict:merge(Map, New_entries).

-spec delete(gleam@dict:dict(EWW, EYN), EWW) -> gleam@dict:dict(EWW, EYN).
delete(Map, Key) ->
    gleam@dict:delete(Map, Key).

-spec drop(gleam@dict:dict(EWZ, EYP), list(EWZ)) -> gleam@dict:dict(EWZ, EYP).
drop(Map, Disallowed_keys) ->
    gleam@dict:drop(Map, Disallowed_keys).

-spec update(
    gleam@dict:dict(EXD, EXE),
    EXD,
    fun((gleam@option:option(EXE)) -> EXE)
) -> gleam@dict:dict(EXD, EXE).
update(Map, Key, Fun) ->
    gleam@dict:update(Map, Key, Fun).

-spec fold(gleam@dict:dict(EXJ, EXK), EXI, fun((EXI, EXJ, EXK) -> EXI)) -> EXI.
fold(Map, Initial, Fun) ->
    gleam@dict:fold(Map, Initial, Fun).
