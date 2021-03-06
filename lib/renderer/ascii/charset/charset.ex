defmodule Bintreeviz.Renderer.Ascii.Charset do
  @moduledoc """
  Bintreeviz.Renderer.Ascii.Charset describes the behaviour to define various charsets to be used to draw the trees.
  """

  @callback top_left_corner() :: String.t()
  @callback top_right_corner() :: String.t()
  @callback bottom_left_corner() :: String.t()
  @callback bottom_right_corner() :: String.t()
  @callback horizontal_line() :: String.t()
  @callback vertical_line() :: String.t()
  @callback node_connector_top() :: String.t()
  @callback node_connector_bottom() :: String.t()
  @callback parent_left_turn_char() :: String.t()
  @callback parent_right_turn_char() :: String.t()
  @callback parent_split_char() :: String.t()
  @callback child_left_turn_char() :: String.t()
  @callback child_right_turn_char() :: String.t()
end
