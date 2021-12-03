module ShoppingList exposing (main)

import Browser
import Html exposing (Html, button, div, input, li, text, ul)
import Html.Attributes exposing (value)
import Html.Events exposing (onClick, onInput)


main =
    Browser.sandbox { init = init, update = update, view = view }


type alias Model =
    { list : List String, input : String }


init : Model
init =
    { list = [], input = "" }


type Msg
    = ChangeInput String
    | Send


valid : String -> Bool
valid value =
    value /= ""


update : Msg -> Model -> Model
update msg model =
    case msg of
        ChangeInput value ->
            { model | input = value }

        Send ->
            if valid model.input then
                { list = model.list ++ [ model.input ], input = "" }

            else
                model


view : Model -> Html Msg
view model =
    div []
        [ ul [] (model.list |> List.map (\item -> li [] [ text item ]))
        , input [ onInput ChangeInput, value model.input ] []
        , button [ onClick Send ] [ text "Add" ]
        ]
