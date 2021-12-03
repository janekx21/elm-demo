module RandomDog exposing (main)

import Browser
import Html exposing (Html, img, text)
import Html.Attributes exposing (src, style)
import Http
import Json.Decode exposing (Decoder, field, string)


main =
    Browser.element { init = init, update = update, view = view, subscriptions = \_ -> Sub.none }


type Model
    = Failure
    | Loading
    | Success { url : String }


init : () -> ( Model, Cmd Msg )
init _ =
    ( Loading, dogRequest )


dogRequest : Cmd Msg
dogRequest =
    Http.get { url = "https://random.dog/woof.json", expect = Http.expectJson GotRandomDog dogDecoder }


dogDecoder : Decoder String
dogDecoder =
    field "url" string


type Msg
    = GotRandomDog (Result Http.Error String)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        GotRandomDog result ->
            case result of
                Ok url ->
                    if String.endsWith ".mp4" url then
                        ( Loading, dogRequest )

                    else
                        ( Success { url = url }, Cmd.none )

                Err _ ->
                    ( Failure, Cmd.none )


view : Model -> Html Msg
view model =
    case model of
        Failure ->
            text "Failure"

        Loading ->
            text "Loading"

        Success dog ->
            img [ src dog.url, style "max-width" "100vw" ] []
