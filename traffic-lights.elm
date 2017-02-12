import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)

main =
    Html.program { init = init, view = view, update = update, subscriptions = subscriptions }



-- MODEL

type alias Model =
  { stopLight : Bool
  , waitLight : Bool
  , goLight : Bool
  }


-- UPDATE

type Msg = ToggleStop | ToggleWait | ToggleGo

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    ToggleStop -> ({model | stopLight = not model.stopLight}, Cmd.none)
    ToggleWait -> ({model | waitLight = not model.waitLight}, Cmd.none)
    ToggleGo -> ({model | goLight = not model.goLight}, Cmd.none)



-- VIEW

view : Model -> Html Msg
view model =
  div [] [
    stylesheet "style.css",
    div [class "buttons"] [
        div [onClick ToggleStop] [text "Stop"],
        div [onClick ToggleWait] [text "Wait"],
        div [onClick ToggleGo] [text "Go"]
    ],
    div [class "lights"] [
        div [class ("stopLight" ++ (turnedOn model.stopLight))] [],
        div [class ("waitLight" ++ (turnedOn model.waitLight))] [],
        div [class ("goLight" ++ (turnedOn model.goLight))] []
    ]
  ]

turnedOn : Bool -> String
turnedOn on =
  if on then
    " on"
  else
    ""

stylesheet : String -> Html Msg
stylesheet url =
    let
        tag = "link"
        attrs =
            [ attribute "rel"       "stylesheet"
            , attribute "property"  "stylesheet"
            , attribute "href"      url
            ]
        children = []
    in
        node tag attrs children


-- SUBSCRIPTIONS

subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none

-- INIT

init : (Model, Cmd Msg)
init = (Model False False False, Cmd.none)
