-module(gleam@result).
-compile([no_auto_import, nowarn_unused_vars, nowarn_unused_function]).

-export([is_ok/1, is_error/1, map/2, map_error/2, flatten/1, 'try'/2, then/2, unwrap/2, lazy_unwrap/2, unwrap_error/2, unwrap_both/1, nil_error/1, 'or'/2, lazy_or/2, all/1, partition/1, replace/2, replace_error/2, values/1, try_recover/2]).

-spec is_ok({ok, any()} | {error, any()}) -> boolean().
is_ok(Result) ->
    case Result of
        {error, _} ->
            false;

        {ok, _} ->
            true
    end.

-spec is_error({ok, any()} | {error, any()}) -> boolean().
is_error(Result) ->
    case Result of
        {ok, _} ->
            false;

        {error, _} ->
            true
    end.

-spec map({ok, BHA} | {error, BHB}, fun((BHA) -> BHE)) -> {ok, BHE} |
    {error, BHB}.
map(Result, Fun) ->
    case Result of
        {ok, X} ->
            {ok, Fun(X)};

        {error, E} ->
            {error, E}
    end.

-spec map_error({ok, BHH} | {error, BHI}, fun((BHI) -> BHL)) -> {ok, BHH} |
    {error, BHL}.
map_error(Result, Fun) ->
    case Result of
        {ok, X} ->
            {ok, X};

        {error, Error} ->
            {error, Fun(Error)}
    end.

-spec flatten({ok, {ok, BHO} | {error, BHP}} | {error, BHP}) -> {ok, BHO} |
    {error, BHP}.
flatten(Result) ->
    case Result of
        {ok, X} ->
            X;

        {error, Error} ->
            {error, Error}
    end.

-spec 'try'({ok, BHW} | {error, BHX}, fun((BHW) -> {ok, BIA} | {error, BHX})) -> {ok,
        BIA} |
    {error, BHX}.
'try'(Result, Fun) ->
    case Result of
        {ok, X} ->
            Fun(X);

        {error, E} ->
            {error, E}
    end.

-spec then({ok, BIF} | {error, BIG}, fun((BIF) -> {ok, BIJ} | {error, BIG})) -> {ok,
        BIJ} |
    {error, BIG}.
then(Result, Fun) ->
    'try'(Result, Fun).

-spec unwrap({ok, BIO} | {error, any()}, BIO) -> BIO.
unwrap(Result, Default) ->
    case Result of
        {ok, V} ->
            V;

        {error, _} ->
            Default
    end.

-spec lazy_unwrap({ok, BIS} | {error, any()}, fun(() -> BIS)) -> BIS.
lazy_unwrap(Result, Default) ->
    case Result of
        {ok, V} ->
            V;

        {error, _} ->
            Default()
    end.

-spec unwrap_error({ok, any()} | {error, BIX}, BIX) -> BIX.
unwrap_error(Result, Default) ->
    case Result of
        {ok, _} ->
            Default;

        {error, E} ->
            E
    end.

-spec unwrap_both({ok, BJA} | {error, BJA}) -> BJA.
unwrap_both(Result) ->
    case Result of
        {ok, A} ->
            A;

        {error, A@1} ->
            A@1
    end.

-spec nil_error({ok, BJD} | {error, any()}) -> {ok, BJD} | {error, nil}.
nil_error(Result) ->
    map_error(Result, fun(_) -> nil end).

-spec 'or'({ok, BJJ} | {error, BJK}, {ok, BJJ} | {error, BJK}) -> {ok, BJJ} |
    {error, BJK}.
'or'(First, Second) ->
    case First of
        {ok, _} ->
            First;

        {error, _} ->
            Second
    end.

-spec lazy_or({ok, BJR} | {error, BJS}, fun(() -> {ok, BJR} | {error, BJS})) -> {ok,
        BJR} |
    {error, BJS}.
lazy_or(First, Second) ->
    case First of
        {ok, _} ->
            First;

        {error, _} ->
            Second()
    end.

-spec all(list({ok, BJZ} | {error, BKA})) -> {ok, list(BJZ)} | {error, BKA}.
all(Results) ->
    gleam@list:try_map(Results, fun(X) -> X end).

-spec do_partition(list({ok, BKO} | {error, BKP}), list(BKO), list(BKP)) -> {list(BKO),
    list(BKP)}.
do_partition(Results, Oks, Errors) ->
    case Results of
        [] ->
            {Oks, Errors};

        [{ok, A} | Rest] ->
            do_partition(Rest, [A | Oks], Errors);

        [{error, E} | Rest@1] ->
            do_partition(Rest@1, Oks, [E | Errors])
    end.

-spec partition(list({ok, BKH} | {error, BKI})) -> {list(BKH), list(BKI)}.
partition(Results) ->
    do_partition(Results, [], []).

-spec replace({ok, any()} | {error, BKX}, BLA) -> {ok, BLA} | {error, BKX}.
replace(Result, Value) ->
    case Result of
        {ok, _} ->
            {ok, Value};

        {error, Error} ->
            {error, Error}
    end.

-spec replace_error({ok, BLD} | {error, any()}, BLH) -> {ok, BLD} | {error, BLH}.
replace_error(Result, Error) ->
    case Result of
        {ok, X} ->
            {ok, X};

        {error, _} ->
            {error, Error}
    end.

-spec values(list({ok, BLK} | {error, any()})) -> list(BLK).
values(Results) ->
    gleam@list:filter_map(Results, fun(R) -> R end).

-spec try_recover(
    {ok, BLQ} | {error, BLR},
    fun((BLR) -> {ok, BLQ} | {error, BLU})
) -> {ok, BLQ} | {error, BLU}.
try_recover(Result, Fun) ->
    case Result of
        {ok, Value} ->
            {ok, Value};

        {error, Error} ->
            Fun(Error)
    end.
