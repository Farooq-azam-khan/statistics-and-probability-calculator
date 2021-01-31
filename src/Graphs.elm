module Graphs exposing (..)

-- import Html exposing (..)
-- import Html.Attributes exposing (..)
-- import Html.Events exposing (..)

import Axis
import Distribution exposing (..)
import Scale exposing (BandScale, ContinuousScale, defaultBandConfig)
import TypedSvg as TS
import TypedSvg.Attributes as TSA
import TypedSvg.Attributes.InPx as TSAIP
import TypedSvg.Core exposing (Svg)
import TypedSvg.Types exposing (AnchorAlignment(..), Transform(..))
import Types exposing (..)


w : Float
w =
    200


h : Float
h =
    200


padding : Float
padding =
    30


xScale : List Int -> BandScale Int
xScale =
    Scale.band { defaultBandConfig | paddingInner = 0.1, paddingOuter = 0.2 } ( 0, w - 2 * padding )


yScale : ContinuousScale Float
yScale =
    Scale.linear ( h - 2 * padding, 0 ) ( 0, 0.3 )


xAxis : List Int -> Svg Msg
xAxis inpts =
    Axis.bottom [] (Scale.toRenderable String.fromInt (xScale inpts))


tick_count : Int
tick_count =
    5


yAxis : Svg Msg
yAxis =
    Axis.left [ Axis.tickCount tick_count ] yScale


column : List Int -> ( Int, Float ) -> Svg Msg
column discrete_input ( val_x, val_y ) =
    TS.g [ TSA.class [ "column" ] ]
        [ TS.rect
            [ TSAIP.x <| Scale.convert (xScale discrete_input) val_x
            , TSAIP.y <| Scale.convert yScale val_y
            , TSAIP.width <| Scale.bandwidth (xScale discrete_input)
            , TSAIP.height <| h - Scale.convert yScale val_y - 2 * padding
            ]
            []
        ]
