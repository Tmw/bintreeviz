defmodule Bintreeviz.Renderer.Ascii do
  @moduledoc """
  Simple ASCII rendering module which, given a tree structure, render its nodes to STDOUT using ASCII characters such as dashes and pipes. Its implemented quite naively but we'll fix that in a next iteration.
  """
  @behaviour Bintreeviz.Renderer
  alias Bintreeviz.Node

  @doc "render/1 takes the starting node and converts it to a rendered representation using ASCII characters"
  @spec render(Node.t(), Bintreeviz.render_options()) :: String.t()
  @impl true
  def render(%Node{} = root, options) do
    do_render(Textmatrix.new(), root, options)
  end

  defp do_render(buffer, nil, _options), do: buffer

  defp do_render(buffer, %Node{} = root, options) do
    buffer
    |> box_node(root, options)
    |> do_render(root.left_child, options)
    |> do_render(root.right_child, options)
    |> connect(root, options)
  end

  defp box_node(buffer, %Node{} = root, options) do
    charset = Keyword.get(options, :ascii_renderer_charset)

    horizontal_line =
      root
      |> Node.width()
      |> Kernel.-(2)
      |> repeat_char(charset.horizontal_line())

    buffer
    |> Textmatrix.write(
      root.x,
      root.y,
      "#{charset.top_left_corner()}#{horizontal_line}#{charset.top_right_corner()}"
    )
    |> Textmatrix.write(
      root.x,
      root.y + 1,
      "#{charset.vertical_line()} #{root.label} #{charset.vertical_line()}"
    )
    |> Textmatrix.write(
      root.x,
      root.y + 2,
      "#{charset.bottom_left_corner()}#{horizontal_line}#{charset.bottom_right_corner()}"
    )
  end

  defp connect(buffer, %Node{left_child: nil, right_child: nil}, _options), do: buffer

  defp connect(buffer, %Node{} = node, options) when is_list(options) do
    case node do
      %Node{left_child: %Node{} = left_child, right_child: %Node{} = right_child} ->
        buffer
        |> connect(node, left_child, options)
        |> connect(node, right_child, options)

      %Node{left_child: %Node{} = left_child, right_child: nil} ->
        connect(buffer, node, left_child, options)

      %Node{left_child: nil, right_child: %Node{} = right_child} ->
        connect(buffer, node, right_child, options)
    end
  end

  defp connect(buffer, %Node{} = root, %Node{} = child, options) when is_list(options) do
    root_anchor_x = floor(Node.width(root) / 2 + root.x)
    root_anchor_y = root.y + 2

    child_anchor_x = floor(Node.width(child) / 2 + child.x)
    child_anchor_y = child.y

    charset = Keyword.get(options, :ascii_renderer_charset)
    # generate the horizontal connecting line between node's anchor points
    line =
      (root_anchor_x - child_anchor_x)
      |> abs()
      |> Kernel.-(1)
      |> repeat_char(charset.horizontal_line())

    # decide which way the corner pieces should face
    child_connection_char = child_connection_char(root_anchor_x, child_anchor_x, options)

    buffer
    # draw connecting characters
    |> Textmatrix.write(root_anchor_x, root_anchor_y, charset.node_connector_bottom())
    |> Textmatrix.write(root_anchor_x, root_anchor_y + 1, charset.vertical_line())
    |> Textmatrix.write(root_anchor_x, root_anchor_y + 2, parent_connection_char(root, options))
    |> Textmatrix.write(child_anchor_x, child_anchor_y - 1, charset.vertical_line())

    # draw connecting corner pices
    |> Textmatrix.write(child_anchor_x, child_anchor_y - 2, child_connection_char)
    |> Textmatrix.write(child_anchor_x, child_anchor_y, charset.node_connector_top())

    # draw connecting horizontal line
    |> Textmatrix.write(min(root_anchor_x, child_anchor_x) + 1, root_anchor_y + 2, "#{line}")
  end

  defp parent_connection_char(%Node{} = root, options) do
    charset = Keyword.get(options, :ascii_renderer_charset)

    case root do
      %Node{left_child: %Node{} = _left_child, right_child: %Node{} = _right_child} ->
        # Got two children
        charset.parent_split_char()

      %Node{left_child: %Node{} = _left_child, right_child: nil} ->
        # Got only left child
        charset.parent_left_turn_char()

      %Node{left_child: nil, right_child: %Node{} = _right_child} ->
        # Got only right child
        charset.parent_right_turn_char()
    end
  end

  defp child_connection_char(root_anchor_x, child_anchor_x, options)
       when root_anchor_x > child_anchor_x do
    # child is ofsetted to the left
    Keyword.get(options, :ascii_renderer_charset).child_right_turn_char()
  end

  defp child_connection_char(root_anchor_x, child_anchor_x, options)
       when root_anchor_x < child_anchor_x do
    # child is offsetted to the right
    Keyword.get(options, :ascii_renderer_charset).child_left_turn_char()
  end

  defp repeat_char(times, char) do
    String.duplicate(char, times)
  end
end
