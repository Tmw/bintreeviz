defmodule Bintreeviz.AsciiRenderer do
  @moduledoc """
  Simple ASCII rendering module which, given a tree structure, render its
  nodes to STDOUT using ASCII characters such as dashes and pipes. Its implemented
  quite naively but we'll fix that in a next iteration.
  """

  alias Bintreeviz.Node

  @spec render(Node.t()) :: String.t()
  def render(%Node{} = root) do
    render(Textmatrix.new(), root)
  end

  defp render(buffer, nil), do: buffer

  defp render(buffer, %Node{} = root) do
    buffer
    |> box_node(root)
    |> render(root.left_child)
    |> render(root.right_child)
    |> connect(root)
  end

  defp box_node(buffer, %Node{} = root) do
    horizontal_line =
      root
      |> Node.width()
      |> Kernel.-(2)
      |> repeat_char("━")

    buffer
    |> Textmatrix.write(root.x, root.y, "┏#{horizontal_line}┓")
    |> Textmatrix.write(root.x, root.y + 1, "┃ #{root.label} ┃")
    |> Textmatrix.write(root.x, root.y + 2, "┗#{horizontal_line}┛")
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
    root_anchor_x = floor(Node.width(root) / 2 + root.x)
    root_anchor_y = root.y + 2

    child_anchor_x = floor(Node.width(child) / 2 + child.x)
    child_anchor_y = child.y

    # generate the horizontal connecting line between node's anchor points
    line =
      (root_anchor_x - child_anchor_x)
      |> abs()
      |> Kernel.-(1)
      |> repeat_char("━")

    # decide which way the corner pieces should face
    child_connection_char = child_connection_char(root_anchor_x, child_anchor_x)

    buffer
    # draw connecting corner pieces for parent
    |> Textmatrix.write(root_anchor_x, root_anchor_y, "┳")
    |> Textmatrix.write(root_anchor_x, root_anchor_y + 1, parent_connection_char(root))

    # draw connecting corner pices
    |> Textmatrix.write(child_anchor_x, child_anchor_y - 1, child_connection_char)
    |> Textmatrix.write(child_anchor_x, child_anchor_y, "┻")

    # draw connecting horizontal line
    |> Textmatrix.write(min(root_anchor_x, child_anchor_x) + 1, root_anchor_y + 1, "#{line}")
  end

  defp parent_connection_char(%Node{} = root) do
    case root do
      %Node{left_child: %Node{} = _left_child, right_child: %Node{} = _right_child} ->
        # Got two children
        "┻"

      %Node{left_child: %Node{} = _left_child, right_child: nil} ->
        # Got only left child
        "┛"

      %Node{left_child: nil, right_child: %Node{} = _right_child} ->
        # Got only right child
        "┗"
    end
  end

  defp child_connection_char(root_anchor_x, child_anchor_x)
       when root_anchor_x > child_anchor_x do
    # child is ofsetted to the left
    "┏"
  end

  defp child_connection_char(root_anchor_x, child_anchor_x)
       when root_anchor_x < child_anchor_x do
    # child is offsetted to the right
    "┓"
  end

  defp repeat_char(times, char) do
    for _i <- 0..(times - 1), do: char
  end
end
