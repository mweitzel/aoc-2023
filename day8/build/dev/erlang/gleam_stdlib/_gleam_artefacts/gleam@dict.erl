-module(gleam@dict).
-compile([no_auto_import, nowarn_unused_vars, nowarn_unused_function]).

-export([size/1, to_list/1, from_list/1, has_key/2, new/0, get/2, insert/3, map_values/2, keys/1, values/1, filter/2, take/2, merge/2, delete/2, drop/2, update/3, fold/3]).
-export_type([dict/2]).

-type dict(LH, LI) :: any() | {gleam_phantom, LH, LI}.

-spec size(dict(any(), any())) -> integer().
size(Dict) ->
    maps:size(Dict).

-spec to_list(dict(LR, LS)) -> list({LR, LS}).
to_list(Dict) ->
    maps:to_list(Dict).

-spec from_list(list({MB, MC})) -> dict(MB, MC).
from_list(List) ->
    maps:from_list(List).

-spec has_key(dict(ML, any()), ML) -> boolean().
has_key(Dict, Key) ->
    maps:is_key(Key, Dict).

-spec new() -> dict(any(), any()).
new() ->
    maps:new().

-spec get(dict(NB, NC), NB) -> {ok, NC} | {error, nil}.
get(From, Get) ->
    gleam_stdlib:map_get(From, Get).

-spec insert(dict(NN, NO), NN, NO) -> dict(NN, NO).
insert(Dict, Key, Value) ->
    maps:put(Key, Value, Dict).

-spec map_values(dict(NZ, OA), fun((NZ, OA) -> OD)) -> dict(NZ, OD).
map_values(Dict, Fun) ->
    maps:map(Fun, Dict).

-spec keys(dict(ON, any())) -> list(ON).
keys(Dict) ->
    maps:keys(Dict).

-spec values(dict(any(), OY)) -> list(OY).
values(Dict) ->
    maps:values(Dict).

-spec filter(dict(PH, PI), fun((PH, PI) -> boolean())) -> dict(PH, PI).
filter(Dict, Predicate) ->
    maps:filter(Predicate, Dict).

-spec take(dict(PT, PU), list(PT)) -> dict(PT, PU).
take(Dict, Desired_keys) ->
    maps:with(Desired_keys, Dict).

-spec merge(dict(QH, QI), dict(QH, QI)) -> dict(QH, QI).
merge(Dict, New_entries) ->
    maps:merge(Dict, New_entries).

-spec delete(dict(QX, QY), QX) -> dict(QX, QY).
delete(Dict, Key) ->
    maps:remove(Key, Dict).

-spec drop(dict(RJ, RK), list(RJ)) -> dict(RJ, RK).
drop(Dict, Disallowed_keys) ->
    case Disallowed_keys of
        [] ->
            Dict;

        [X | Xs] ->
            drop(delete(Dict, X), Xs)
    end.

-spec update(dict(RQ, RR), RQ, fun((gleam@option:option(RR)) -> RR)) -> dict(RQ, RR).
update(Dict, Key, Fun) ->
    _pipe = Dict,
    _pipe@1 = get(_pipe, Key),
    _pipe@2 = gleam@option:from_result(_pipe@1),
    _pipe@3 = Fun(_pipe@2),
    insert(Dict, Key, _pipe@3).

-spec do_fold(list({RX, RY}), SA, fun((SA, RX, RY) -> SA)) -> SA.
do_fold(List, Initial, Fun) ->
    case List of
        [] ->
            Initial;

        [{K, V} | Rest] ->
            do_fold(Rest, Fun(Initial, K, V), Fun)
    end.

-spec fold(dict(SB, SC), SF, fun((SF, SB, SC) -> SF)) -> SF.
fold(Dict, Initial, Fun) ->
    _pipe = Dict,
    _pipe@1 = to_list(_pipe),
    do_fold(_pipe@1, Initial, Fun).
