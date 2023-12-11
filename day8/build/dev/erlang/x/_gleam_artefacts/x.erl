-module(x).
-compile([no_auto_import, nowarn_unused_vars, nowarn_unused_function]).

-export([next/2, lr/1, access/2, solve1/1, main/0]).
-export_type([round/0]).

-opaque round() :: {round, integer(), binary(), binary()}.

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
                        line => 82})
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
                        line => 83})
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
                        line => 68})
    end,
    Next.

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
                        line => 18})
    end,
    Lines@1 = gleam@list:drop(Lines, 1),
    Lines@2 = gleam@list:filter(
        Lines@1,
        fun(Line) -> gleam@string:length(Line) > 1 end
    ),
    Nodes@1 = begin
        _pipe = gleam@iterator:from_list(Lines@2),
        gleam@iterator:fold(
            _pipe,
            gleam@dict:new(),
            fun(Nodes, Line@1) ->
                _assert_subject@1 = begin
                    _pipe@1 = Line@1,
                    _pipe@2 = gleam@string:split(_pipe@1, <<" = "/utf8>>),
                    gleam@list:first(_pipe@2)
                end,
                {ok, Key} = case _assert_subject@1 of
                    {ok, _} -> _assert_subject@1;
                    _assert_fail@1 ->
                        erlang:error(#{gleam_error => let_assert,
                                    message => <<"Assertion pattern match failed"/utf8>>,
                                    value => _assert_fail@1,
                                    module => <<"x"/utf8>>,
                                    function => <<"solve1"/utf8>>,
                                    line => 24})
                end,
                _assert_subject@2 = begin
                    _pipe@3 = Line@1,
                    _pipe@4 = gleam@string:split(_pipe@3, <<" = "/utf8>>),
                    gleam@list:last(_pipe@4)
                end,
                {ok, Vals} = case _assert_subject@2 of
                    {ok, _} -> _assert_subject@2;
                    _assert_fail@2 ->
                        erlang:error(#{gleam_error => let_assert,
                                    message => <<"Assertion pattern match failed"/utf8>>,
                                    value => _assert_fail@2,
                                    module => <<"x"/utf8>>,
                                    function => <<"solve1"/utf8>>,
                                    line => 28})
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
                _assert_subject@3 = gleam@list:first(Vals@1),
                {ok, Left} = case _assert_subject@3 of
                    {ok, _} -> _assert_subject@3;
                    _assert_fail@3 ->
                        erlang:error(#{gleam_error => let_assert,
                                    message => <<"Assertion pattern match failed"/utf8>>,
                                    value => _assert_fail@3,
                                    module => <<"x"/utf8>>,
                                    function => <<"solve1"/utf8>>,
                                    line => 38})
                end,
                _assert_subject@4 = gleam@list:last(Vals@1),
                {ok, Right} = case _assert_subject@4 of
                    {ok, _} -> _assert_subject@4;
                    _assert_fail@4 ->
                        erlang:error(#{gleam_error => let_assert,
                                    message => <<"Assertion pattern match failed"/utf8>>,
                                    value => _assert_fail@4,
                                    module => <<"x"/utf8>>,
                                    function => <<"solve1"/utf8>>,
                                    line => 39})
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
    Round = {round, 0, Header, <<"AAA"/utf8>>},
    Final = begin
        _pipe@11 = gleam@iterator:unfold(
            Round,
            fun(Round@1) -> case erlang:element(4, Round@1) of
                    <<"ZZZ"/utf8>> ->
                        done;

                    _ ->
                        Next_key = access(Nodes@1, Round@1),
                        Rounder = next(Round@1, Next_key),
                        {next, Rounder, Rounder}
                end end
        ),
        _pipe@12 = gleam@iterator:last(_pipe@11),
        gleam@result:unwrap(_pipe@12, {round, -1, <<""/utf8>>, <<""/utf8>>})
    end,
    erlang:element(2, Final).

-spec main() -> nil.
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
    gleam@io:println(gleam@int:to_string(solve1(A))).
