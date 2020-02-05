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
    IO.write(IO.ANSI.clear())
    do_render(root)

    # figure out how tall the tree is by taking the tree depth and multiplying
    # it very naively with 5 ( 3 lines for the node itself + 2 for the margin).
    # Move the cursor there so any input that is writting to STDOUT after
    # wont mess up the drawn tree.
    bottom = Bintreeviz.Layouthelper.tree_depth(root) * 5
    IO.write(IO.ANSI.cursor(bottom, 0))
  end

  defp do_render(nil), do: nil

  defp do_render(%Node{} = root) do
    line =
      root
      |> node_width()
      |> Kernel.-(2)
      |> repeat_char("-")

    line = "+#{line}+"

    IO.write(IO.ANSI.cursor(root.y + @offset_y, root.x + @offset_x))
    IO.write("#{line}")

    IO.write(IO.ANSI.cursor(root.y + 1 + @offset_y, root.x + @offset_x))
    IO.write("| #{root.label} |\n")

    IO.write(IO.ANSI.cursor(root.y + 2 + @offset_y, root.x + @offset_x))
    IO.write("#{line}\n")

    do_render(root.left_child)
    do_render(root.right_child)
  end

  # return the node's label length + padding + border.
  defp node_width(%Node{label: label} = _node) do
    String.length(label) + @node_padding
  end

  defp repeat_char(times, char) do
    for _i <- 0..(times - 1), do: char
  end
end

defmodule Bintreeviz.Layouthelper do
  @moduledoc """
  Internal module with helper functions for calculating the height of the tree
  """
  def tree_depth(root, level \\ 0)

  def tree_depth(nil, level), do: level

  def tree_depth(root, level) do
    max(
      tree_depth(root.left_child, level + 1),
      tree_depth(root.right_child, level + 1)
    )
  end
end
