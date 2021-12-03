module ShoppingElement exposing (main)

import Browser
import Html exposing (Html, button, div, input, li, text, ul)
import Html.Attributes exposing (value)
import Html.Events exposing (onClick, onInput)


main =
    Browser.element { init = init, update = update, view = view, subscriptions = \_ -> Sub.none }


type alias Model =
    { list : List String, input : String }


init : () -> ( Model, Cmd Msg )
init _ =
    ( { list = [], input = "" }, Cmd.none )


type Msg
    = ChangeInput String
    | Send


valid : String -> Bool
valid value =
    value /= ""


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ChangeInput value ->
            ( { model | input = value }, Cmd.none )

        Send ->
            if valid model.input then
                ( { list = model.list ++ [ model.input ], input = "" }, Cmd.none )

            else
                ( model, Cmd.none )


view : Model -> Html Msg
view model =
    div []
        [ ul [] (model.list |> List.map (\item -> li [] [ text item ]))
        , input [ onInput ChangeInput, value model.input ] []
        , button [ onClick Send ] [ text "Add" ]
        ]
