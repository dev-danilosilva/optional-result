module OptionalResult exposing
    ( OptionalResult(..)
    , fromMaybe
    , fromResult
    , map
    , map2
    , map3
    , map4
    , map5
    , map6
    , mapError
    , mapError2
    )


type OptionalResult error success
    = Empty
    | Error error
    | Success success


map : (a -> c) -> OptionalResult b a -> OptionalResult b c
map fn or =
    case or of
        Success x ->
            Success (fn x)

        Error x ->
            Error x

        Empty ->
            Empty


map2 : (a -> b -> c) -> OptionalResult x a -> OptionalResult x b -> OptionalResult x c
map2 fn or1 or2 =
    case ( or1, or2 ) of
        ( Success x1, Success x2 ) ->
            Success <| fn x1 x2

        ( Error err, _ ) ->
            Error err

        ( _, Error err ) ->
            Error err

        _ ->
            Empty


map3 : (a -> b -> c -> d) -> OptionalResult x a -> OptionalResult x b -> OptionalResult x c -> OptionalResult x d
map3 fn or1 or2 or3 =
    case ( or1, or2, or3 ) of
        ( Success x1, Success x2, Success x3 ) ->
            Success <| fn x1 x2 x3

        ( Error err, _, _ ) ->
            Error err

        ( _, Error err, _ ) ->
            Error err

        ( _, _, Error err ) ->
            Error err

        _ ->
            Empty


map4 :
    (a -> b -> c -> d -> e)
    -> OptionalResult x a
    -> OptionalResult x b
    -> OptionalResult x c
    -> OptionalResult x d
    -> OptionalResult x e
map4 fn or1 or2 or3 or4 =
    case or1 of
        Error error ->
            Error error

        Empty ->
            Empty

        Success val1 ->
            case or2 of
                Error error ->
                    Error error

                Empty ->
                    Empty

                Success val2 ->
                    case or3 of
                        Error error ->
                            Error error

                        Empty ->
                            Empty

                        Success val3 ->
                            case or4 of
                                Error error ->
                                    Error error

                                Empty ->
                                    Empty

                                Success val4 ->
                                    Success <| fn val1 val2 val3 val4


map5 :
    (a -> b -> c -> d -> e -> f)
    -> OptionalResult x a
    -> OptionalResult x b
    -> OptionalResult x c
    -> OptionalResult x d
    -> OptionalResult x e
    -> OptionalResult x f
map5 fn or1 or2 or3 or4 or5 =
    case or1 of
        Error error1 ->
            Error error1

        Empty ->
            Empty

        Success val1 ->
            case or2 of
                Error error2 ->
                    Error error2

                Empty ->
                    Empty

                Success val2 ->
                    case or3 of
                        Error error3 ->
                            Error error3

                        Empty ->
                            Empty

                        Success val3 ->
                            case or4 of
                                Error error4 ->
                                    Error error4

                                Empty ->
                                    Empty

                                Success val4 ->
                                    case or5 of
                                        Error error5 ->
                                            Error error5

                                        Empty ->
                                            Empty

                                        Success val5 ->
                                            Success <| fn val1 val2 val3 val4 val5


map6 :
    (a -> b -> c -> d -> e -> f -> g)
    -> OptionalResult x a
    -> OptionalResult x b
    -> OptionalResult x c
    -> OptionalResult x d
    -> OptionalResult x e
    -> OptionalResult x f
    -> OptionalResult x g
map6 fn or1 or2 or3 or4 or5 or6 =
    case or1 of
        Error error1 ->
            Error error1

        Empty ->
            Empty

        Success val1 ->
            case or2 of
                Error error2 ->
                    Error error2

                Empty ->
                    Empty

                Success val2 ->
                    case or3 of
                        Error error3 ->
                            Error error3

                        Empty ->
                            Empty

                        Success val3 ->
                            case or4 of
                                Error error4 ->
                                    Error error4

                                Empty ->
                                    Empty

                                Success val4 ->
                                    case or5 of
                                        Error error5 ->
                                            Error error5

                                        Empty ->
                                            Empty

                                        Success val5 ->
                                            case or6 of
                                                Error error6 ->
                                                    Error error6

                                                Empty ->
                                                    Empty

                                                Success val6 ->
                                                    Success <| fn val1 val2 val3 val4 val5 val6


mapError : (a -> c) -> OptionalResult a x -> OptionalResult c x
mapError fn or =
    case or of
        Error err ->
            Error <| fn err

        Success val ->
            Success val

        Empty ->
            Empty

mapError2 : (error1 -> error2 -> error3) -> OptionalResult error1 x -> OptionalResult error2 x -> OptionalResult error3 x
mapError2 fn or1 or2 =
    case (or1, or2) of
        (Error err1, Error err2) ->
            Error <| fn err1 err2
        (Success suc1, _) ->
            Success suc1
        (_, Success suc2) ->
            Success suc2
        (Empty, _) ->
            Empty
        (_, Empty) ->
            Empty

fromMaybe : Maybe success -> OptionalResult error success
fromMaybe mb =
    case mb of
        Just val ->
            Success val

        Nothing ->
            Empty


fromResult : Result error success -> OptionalResult error success
fromResult res =
    case res of
        Ok value ->
            Success value

        Err error ->
            Error error
