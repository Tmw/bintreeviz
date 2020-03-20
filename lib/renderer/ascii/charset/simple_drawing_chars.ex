defmodule Bintreeviz.Renderer.Ascii.Charset.SimpleDrawingChars do
  @moduledoc """
  SimpleDrawingChars defines the characters to use for drawing simple boxes with dashes, pipes and plus signs.
  """
  @behaviour Bintreeviz.Renderer.Ascii.Charset

  # characters for drawing the box
  def top_left_corner, do: "+"
  def top_right_corner, do: "+"
  def bottom_left_corner, do: "+"
  def bottom_right_corner, do: "+"

  # characters for drawing horizontal and vertical lines
  def horizontal_line, do: "-"
  def vertical_line, do: "|"

  # characters for drawing the connections
  def node_connector_top, do: "+"
  def node_connector_bottom, do: "+"

  # characters for drawing the connection corners closest to the parent
  def parent_left_turn_char, do: "+"
  def parent_right_turn_char, do: "+"
  def parent_split_char, do: "+"

  # characers for drawing the connection corners closest to the child
  def child_left_turn_char, do: "+"
  def child_right_turn_char, do: "+"
end
