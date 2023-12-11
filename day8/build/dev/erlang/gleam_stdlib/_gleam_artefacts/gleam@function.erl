-module(gleam@function).
-compile([no_auto_import, nowarn_unused_vars, nowarn_unused_function]).

-export([compose/2, curry2/1, curry3/1, curry4/1, curry5/1, curry6/1, flip/1, identity/1, constant/1, tap/2, apply1/2, apply2/3, apply3/4]).

-spec compose(fun((FER) -> FES), fun((FES) -> FET)) -> fun((FER) -> FET).
compose(Fun1, Fun2) ->
    fun(A) -> Fun2(Fun1(A)) end.

-spec curry2(fun((FEU, FEV) -> FEW)) -> fun((FEU) -> fun((FEV) -> FEW)).
curry2(Fun) ->
    fun(A) -> fun(B) -> Fun(A, B) end end.

-spec curry3(fun((FEY, FEZ, FFA) -> FFB)) -> fun((FEY) -> fun((FEZ) -> fun((FFA) -> FFB))).
curry3(Fun) ->
    fun(A) -> fun(B) -> fun(C) -> Fun(A, B, C) end end end.

-spec curry4(fun((FFD, FFE, FFF, FFG) -> FFH)) -> fun((FFD) -> fun((FFE) -> fun((FFF) -> fun((FFG) -> FFH)))).
curry4(Fun) ->
    fun(A) -> fun(B) -> fun(C) -> fun(D) -> Fun(A, B, C, D) end end end end.

-spec curry5(fun((FFJ, FFK, FFL, FFM, FFN) -> FFO)) -> fun((FFJ) -> fun((FFK) -> fun((FFL) -> fun((FFM) -> fun((FFN) -> FFO))))).
curry5(Fun) ->
    fun(A) ->
        fun(B) ->
            fun(C) -> fun(D) -> fun(E) -> Fun(A, B, C, D, E) end end end
        end
    end.

-spec curry6(fun((FFQ, FFR, FFS, FFT, FFU, FFV) -> FFW)) -> fun((FFQ) -> fun((FFR) -> fun((FFS) -> fun((FFT) -> fun((FFU) -> fun((FFV) -> FFW)))))).
curry6(Fun) ->
    fun(A) ->
        fun(B) ->
            fun(C) ->
                fun(D) -> fun(E) -> fun(F) -> Fun(A, B, C, D, E, F) end end end
            end
        end
    end.

-spec flip(fun((FFY, FFZ) -> FGA)) -> fun((FFZ, FFY) -> FGA).
flip(Fun) ->
    fun(B, A) -> Fun(A, B) end.

-spec identity(FGB) -> FGB.
identity(X) ->
    X.

-spec constant(FGC) -> fun((any()) -> FGC).
constant(Value) ->
    fun(_) -> Value end.

-spec tap(FGE, fun((FGE) -> any())) -> FGE.
tap(Arg, Effect) ->
    Effect(Arg),
    Arg.

-spec apply1(fun((FGG) -> FGH), FGG) -> FGH.
apply1(Fun, Arg1) ->
    Fun(Arg1).

-spec apply2(fun((FGI, FGJ) -> FGK), FGI, FGJ) -> FGK.
apply2(Fun, Arg1, Arg2) ->
    Fun(Arg1, Arg2).

-spec apply3(fun((FGL, FGM, FGN) -> FGO), FGL, FGM, FGN) -> FGO.
apply3(Fun, Arg1, Arg2, Arg3) ->
    Fun(Arg1, Arg2, Arg3).
