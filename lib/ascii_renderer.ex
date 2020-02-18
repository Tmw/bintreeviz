defmodule Bintreeviz.AsciiRenderer do
  @moduledoc """
  Simple ASCII rendering module which, given a tree structure, render its
  nodes to STDOUT using ASCII characters such as dashes and pipes. Its implemented
  quite naively but we'll fix that in a next iteration.
  """

  @node_padding 4
  @offset_y 1
  @offset_x 1
  alias Bintreeviz.Node

  def render(%Node{} = root) do
    buffer = Textmatrix.new()
    buffer = do_render(root, buffer)
    IO.puts(buffer)
  end

  defp do_render(nil, buffer), do: buffer

  defp do_render(%Node{} = root, buffer) do
    line = make_line_for_node(root)

    buffer =
      buffer
      |> Textmatrix.write(root.x + @offset_x, root.y + @offset_y, line)
      |> Textmatrix.write(root.x + @offset_x, root.y + @offset_y + 1, "| #{root.label} |")
      |> Textmatrix.write(root.x + @offset_x, root.y + 2 + @offset_y, line)

    buffer = do_render(root.left_child, buffer)
    do_render(root.right_child, buffer)
  end

  defp make_line_for_node(%Node{} = node) do
    line =
      node
      |> node_width()
      |> Kernel.-(2)
      |> repeat_char("-")

    "+#{line}+"
  end

  # return the node's label length + padding + border.
  defp node_width(%Node{label: label} = _node) do
    String.length(label) + @node_padding
  end

  defp repeat_char(times, char) do
    for _i <- 0..(times - 1), do: char
  end
end
