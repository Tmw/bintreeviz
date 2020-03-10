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
    Textmatrix.new()
    |> do_render(root)
    |> IO.puts()
  end

  defp do_render(buffer, nil), do: buffer

  defp do_render(buffer, %Node{} = root) do
    top_line = make_line_for_node(root, :top)
    bottom_line = make_line_for_node(root, :bottom)

    buffer =
      buffer
      |> Textmatrix.write(root.x + @offset_x, root.y + @offset_y, top_line)
      |> Textmatrix.write(root.x + @offset_x, root.y + @offset_y + 1, "┃ #{root.label} ┃")
      |> Textmatrix.write(root.x + @offset_x, root.y + 2 + @offset_y, bottom_line)

    buffer
    |> do_render(root.left_child)
    |> do_render(root.right_child)
    |> connect(root)
  end

  defp connect(buffer, %Node{left_child: nil, right_child: nil}), do: buffer

  defp connect(buffer, %Node{} = node) do
    case node do
      %Node{left_child: %Node{} = left_child, right_child: %Node{} = right_child} ->
        buffer
        |> connect(node, left_child)
        |> connect(node, right_child)

      %Node{left_child: %Node{} = left_child, right_child: nil} ->
        connect(buffer, node, left_child)

      %Node{left_child: nil, right_child: %Node{} = right_child} ->
        connect(buffer, node, right_child)
    end
  end

  defp connect(buffer, %Node{} = root, %Node{} = child) do
    root_anchor_x = (node_width(root) / 2 + root.x) |> floor()
    root_anchor_y = root.y + 3

    child_anchor_x = (node_width(child) / 2 + child.x) |> floor()
    child_anchor_y = child.y + 1

    buffer
    |> Textmatrix.write(root_anchor_x, root_anchor_y, "┳")
    |> Textmatrix.write(root_anchor_x, root_anchor_y + 1, "┻")
    |> Textmatrix.write(child_anchor_x, child_anchor_y - 1, "┳")
    |> Textmatrix.write(child_anchor_x, child_anchor_y, "┻")
  end

  defp make_line_for_node(%Node{} = node, :top) do
    line =
      node
      |> node_width()
      |> Kernel.-(2)
      |> repeat_char("━")

    "┏#{line}┓"
  end

  defp make_line_for_node(%Node{} = node, :bottom) do
    line =
      node
      |> node_width()
      |> Kernel.-(2)
      |> repeat_char("━")

    "┗#{line}┛"
  end

  # return the node's label length + padding + border.
  defp node_width(%Node{label: label} = _node) do
    String.length(label) + @node_padding
  end

  defp repeat_char(times, char) do
    for _i <- 0..(times - 1), do: char
  end
end
