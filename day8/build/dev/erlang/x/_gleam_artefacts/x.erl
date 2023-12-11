-module(x).
-compile([no_auto_import, nowarn_unused_vars, nowarn_unused_function]).

-export([solve1/1, solve2/1, main/0]).
-export_type([carry/0, round/0]).

-type carry() :: {carry, integer(), list(integer()), integer()}.

-type round() :: {round, integer(), binary(), binary()}.

-spec prime_factors(integer()) -> list(integer()).
prime_factors(To_factor) ->
    Factors = begin
        _pipe = gleam@iterator:unfold(
            {carry, To_factor, [], 2},
            fun(C) -> case erlang:element(2, C) of
                    1 ->
                        done;

                    _ ->
                        Remainder = case erlang:element(4, C) of
                            0 -> 0;
                            Gleam@denominator -> erlang:element(2, C) rem Gleam@denominator
                        end,
                        case Remainder of
                            0 ->
                                To_factor@1 = case erlang:element(4, C) of
                                    0 -> 0;
                                    Gleam@denominator@1 -> erlang:element(2, C)
                                    div Gleam@denominator@1
                                end,
                                Out = {carry,
                                    To_factor@1,
                                    gleam@list:append(
                                        erlang:element(3, C),
                                        [erlang:element(4, C)]
                                    ),
                                    erlang:element(4, C)},
                                {next, Out, Out};

                            _ ->
                                Out@1 = {carry,
                                    erlang:element(2, C),
                                    erlang:element(3, C),
                                    erlang:element(4, C) + 1},
                                {next, Out@1, Out@1}
                        end
                end end
        ),
        _pipe@1 = gleam@iterator:last(_pipe),
        gleam@result:unwrap(_pipe@1, {carry, -1, [-1], -1})
    end,
    erlang:element(3, Factors).

-spec find_lcm(list(integer())) -> integer().
find_lcm(Nums) ->
    _pipe = Nums,
    _pipe@1 = gleam@iterator:from_list(_pipe),
    _pipe@2 = gleam@iterator:map(_pipe@1, fun(A) -> prime_factors(A) end),
    _pipe@3 = gleam@iterator:to_list(_pipe@2),
    gleam@io:debug(_pipe@3),
    gleam@io:println(
        <<"^^^ these are prime factors, LCM is the highest of each power multiplied together"/utf8>>
    ),
    gleam@io:println(
        <<"I noticed in my dataset there were no sets like [2,2,3] and [2,3,3]"/utf8>>
    ),
    gleam@io:println(
        <<"Only sets like [3,19],[5,19], so I skipped the programming challenge to filter"/utf8>>
    ),
    gleam@io:println(
        <<"Instead I just multilied the uniq primes together and submitted."/utf8>>
    ),
    -1.

-spec prepare_dict(list(binary())) -> gleam@dict:dict(binary(), binary()).
prepare_dict(Lines) ->
    Nodes@1 = begin
        _pipe = gleam@iterator:from_list(Lines),
        gleam@iterator:fold(
            _pipe,
            gleam@dict:new(),
            fun(Nodes, Line) ->
                _assert_subject = begin
                    _pipe@1 = Line,
                    _pipe@2 = gleam@string:split(_pipe@1, <<" = "/utf8>>),
                    gleam@list:first(_pipe@2)
                end,
                {ok, Key} = case _assert_subject of
                    {ok, _} -> _assert_subject;
                    _assert_fail ->
                        erlang:error(#{gleam_error => let_assert,
                                    message => <<"Assertion pattern match failed"/utf8>>,
                                    value => _assert_fail,
                                    module => <<"x"/utf8>>,
                                    function => <<"prepare_dict"/utf8>>,
                                    line => 120})
                end,
                _assert_subject@1 = begin
                    _pipe@3 = Line,
                    _pipe@4 = gleam@string:split(_pipe@3, <<" = "/utf8>>),
                    gleam@list:last(_pipe@4)
                end,
                {ok, Vals} = case _assert_subject@1 of
                    {ok, _} -> _assert_subject@1;
                    _assert_fail@1 ->
                        erlang:error(#{gleam_error => let_assert,
                                    message => <<"Assertion pattern match failed"/utf8>>,
                                    value => _assert_fail@1,
                                    module => <<"x"/utf8>>,
                                    function => <<"prepare_dict"/utf8>>,
                                    line => 124})
                end,
                Vals@1 = begin
                    _pipe@5 = Vals,
                    _pipe@6 = gleam@string:replace(
                        _pipe@5,
                        <<"("/utf8>>,
                        <<""/utf8>>
                    ),
                    _pipe@7 = gleam@string:replace(
                        _pipe@6,
                        <<")"/utf8>>,
                        <<""/utf8>>
                    ),
                    _pipe@8 = gleam@string:replace(
                        _pipe@7,
                        <<","/utf8>>,
                        <<""/utf8>>
                    ),
                    gleam@string:split(_pipe@8, <<" "/utf8>>)
                end,
                _assert_subject@2 = gleam@list:first(Vals@1),
                {ok, Left} = case _assert_subject@2 of
                    {ok, _} -> _assert_subject@2;
                    _assert_fail@2 ->
                        erlang:error(#{gleam_error => let_assert,
                                    message => <<"Assertion pattern match failed"/utf8>>,
                                    value => _assert_fail@2,
                                    module => <<"x"/utf8>>,
                                    function => <<"prepare_dict"/utf8>>,
                                    line => 134})
                end,
                _assert_subject@3 = gleam@list:last(Vals@1),
                {ok, Right} = case _assert_subject@3 of
                    {ok, _} -> _assert_subject@3;
                    _assert_fail@3 ->
                        erlang:error(#{gleam_error => let_assert,
                                    message => <<"Assertion pattern match failed"/utf8>>,
                                    value => _assert_fail@3,
                                    module => <<"x"/utf8>>,
                                    function => <<"prepare_dict"/utf8>>,
                                    line => 135})
                end,
                _pipe@9 = Nodes,
                _pipe@10 = gleam@dict:insert(
                    _pipe@9,
                    gleam@string:join([Key, <<"-L"/utf8>>], <<""/utf8>>),
                    Left
                ),
                gleam@dict:insert(
                    _pipe@10,
                    gleam@string:join([Key, <<"-R"/utf8>>], <<""/utf8>>),
                    Right
                )
            end
        )
    end,
    Nodes@1.

-spec current_nth_letter(round(), integer()) -> binary().
current_nth_letter(Round, N) ->
    _assert_subject = gleam@list:at(
        gleam@string:split(erlang:element(4, Round), <<""/utf8>>),
        N
    ),
    {ok, Last_letter} = case _assert_subject of
        {ok, _} -> _assert_subject;
        _assert_fail ->
            erlang:error(#{gleam_error => let_assert,
                        message => <<"Assertion pattern match failed"/utf8>>,
                        value => _assert_fail,
                        module => <<"x"/utf8>>,
                        function => <<"current_nth_letter"/utf8>>,
                        line => 145})
    end,
    Last_letter.

-spec next(round(), binary()) -> round().
next(Round, New) ->
    erlang:setelement(
        4,
        erlang:setelement(2, Round, erlang:element(2, Round) + 1),
        New
    ).

-spec lr(round()) -> binary().
lr(Round) ->
    Lrlr = gleam@string:split(erlang:element(3, Round), <<""/utf8>>),
    _assert_subject = gleam@int:modulo(
        erlang:element(2, Round),
        gleam@list:length(Lrlr)
    ),
    {ok, Idx} = case _assert_subject of
        {ok, _} -> _assert_subject;
        _assert_fail ->
            erlang:error(#{gleam_error => let_assert,
                        message => <<"Assertion pattern match failed"/utf8>>,
                        value => _assert_fail,
                        module => <<"x"/utf8>>,
                        function => <<"lr"/utf8>>,
                        line => 186})
    end,
    _assert_subject@1 = gleam@list:at(Lrlr, Idx),
    {ok, Lrlr@1} = case _assert_subject@1 of
        {ok, _} -> _assert_subject@1;
        _assert_fail@1 ->
            erlang:error(#{gleam_error => let_assert,
                        message => <<"Assertion pattern match failed"/utf8>>,
                        value => _assert_fail@1,
                        module => <<"x"/utf8>>,
                        function => <<"lr"/utf8>>,
                        line => 187})
    end,
    Lrlr@1.

-spec access(gleam@dict:dict(binary(), binary()), round()) -> binary().
access(Nodes, Round) ->
    Key = gleam@string:join(
        [erlang:element(4, Round), <<"-"/utf8>>, lr(Round)],
        <<""/utf8>>
    ),
    _assert_subject = gleam@dict:get(Nodes, Key),
    {ok, Next} = case _assert_subject of
        {ok, _} -> _assert_subject;
        _assert_fail ->
            erlang:error(#{gleam_error => let_assert,
                        message => <<"Assertion pattern match failed"/utf8>>,
                        value => _assert_fail,
                        module => <<"x"/utf8>>,
                        function => <<"access"/utf8>>,
                        line => 172})
    end,
    Next.

-spec solve_round(gleam@dict:dict(binary(), binary()), round()) -> integer().
solve_round(Nodes, Round) ->
    Final = begin
        _pipe = gleam@iterator:unfold(
            Round,
            fun(Round@1) ->
                Potentially_z = current_nth_letter(Round@1, 2),
                case Potentially_z of
                    <<"Z"/utf8>> ->
                        done;

                    _ ->
                        Next_key = access(Nodes, Round@1),
                        Rounder = next(Round@1, Next_key),
                        {next, Rounder, Rounder}
                end
            end
        ),
        _pipe@1 = gleam@iterator:last(_pipe),
        gleam@result:unwrap(_pipe@1, {round, -1, <<""/utf8>>, <<""/utf8>>})
    end,
    erlang:element(2, Final).

-spec solve1(binary()) -> integer().
solve1(Input) ->
    Lines = gleam@string:split(Input, <<"\n"/utf8>>),
    _assert_subject = gleam@list:first(Lines),
    {ok, Header} = case _assert_subject of
        {ok, _} -> _assert_subject;
        _assert_fail ->
            erlang:error(#{gleam_error => let_assert,
                        message => <<"Assertion pattern match failed"/utf8>>,
                        value => _assert_fail,
                        module => <<"x"/utf8>>,
                        function => <<"solve1"/utf8>>,
                        line => 22})
    end,
    Lines@1 = gleam@list:drop(Lines, 1),
    Lines@2 = gleam@list:filter(
        Lines@1,
        fun(Line) -> gleam@string:length(Line) > 1 end
    ),
    Nodes = prepare_dict(Lines@2),
    Round = {round, 0, Header, <<"AAA"/utf8>>},
    solve_round(Nodes, Round).

-spec solve2(binary()) -> integer().
solve2(Input) ->
    Lines = gleam@string:split(Input, <<"\n"/utf8>>),
    _assert_subject = gleam@list:first(Lines),
    {ok, Header} = case _assert_subject of
        {ok, _} -> _assert_subject;
        _assert_fail ->
            erlang:error(#{gleam_error => let_assert,
                        message => <<"Assertion pattern match failed"/utf8>>,
                        value => _assert_fail,
                        module => <<"x"/utf8>>,
                        function => <<"solve2"/utf8>>,
                        line => 35})
    end,
    Lines@1 = gleam@list:drop(Lines, 1),
    Lines@2 = gleam@list:filter(
        Lines@1,
        fun(Line) -> gleam@string:length(Line) > 1 end
    ),
    Nodes = prepare_dict(Lines@2),
    Rounds = begin
        _pipe = Lines@2,
        _pipe@1 = gleam@iterator:from_list(_pipe),
        _pipe@4 = gleam@iterator:map(
            _pipe@1,
            fun(Line@1) ->
                _assert_subject@1 = begin
                    _pipe@2 = Line@1,
                    _pipe@3 = gleam@string:split(_pipe@2, <<" = "/utf8>>),
                    gleam@list:first(_pipe@3)
                end,
                {ok, Key} = case _assert_subject@1 of
                    {ok, _} -> _assert_subject@1;
                    _assert_fail@1 ->
                        erlang:error(#{gleam_error => let_assert,
                                    message => <<"Assertion pattern match failed"/utf8>>,
                                    value => _assert_fail@1,
                                    module => <<"x"/utf8>>,
                                    function => <<"solve2"/utf8>>,
                                    line => 44})
                end,
                Key
            end
        ),
        _pipe@5 = gleam@iterator:map(
            _pipe@4,
            fun(Key@1) -> {round, 0, Header, Key@1} end
        ),
        _pipe@6 = gleam@iterator:filter(
            _pipe@5,
            fun(Round) -> case current_nth_letter(Round, 2) of
                    <<"A"/utf8>> ->
                        true;

                    _ ->
                        false
                end end
        ),
        gleam@iterator:to_list(_pipe@6)
    end,
    Solutions = begin
        _pipe@7 = Rounds,
        _pipe@8 = gleam@iterator:from_list(_pipe@7),
        _pipe@9 = gleam@iterator:map(
            _pipe@8,
            fun(_capture) -> solve_round(Nodes, _capture) end
        ),
        gleam@iterator:to_list(_pipe@9)
    end,
    find_lcm(Solutions).

-spec main() -> integer().
main() ->
    _assert_subject = simplifile:read(<<"./input"/utf8>>),
    {ok, A} = case _assert_subject of
        {ok, _} -> _assert_subject;
        _assert_fail ->
            erlang:error(#{gleam_error => let_assert,
                        message => <<"Assertion pattern match failed"/utf8>>,
                        value => _assert_fail,
                        module => <<"x"/utf8>>,
                        function => <<"main"/utf8>>,
                        line => 11})
    end,
    gleam@io:debug(solve2(A)).
