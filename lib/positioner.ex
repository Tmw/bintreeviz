defmodule Bintreeviz.Positioner do
  require Logger

  @moduledoc """
  Module to do the actual positioning. As described in the original paper,
  this algorithm works with two loops to keep the algorithm performing in O(N).
  """
  alias Bintreeviz.Node

  def position(%Node{} = root) do
    {root, nexts, _offsets} = first_walk(root)

    {root, _nexts} =
      second_walk(
        root,
        nexts
      )

    root
  end

  defp first_walk(root, depth \\ 0, nexts \\ %{}, offsets \\ %{})

  defp first_walk(nil, _depth, nexts, offsets), do: {nil, nexts, offsets}

  defp first_walk(%Node{} = root, depth, nexts, offsets) do
    {left_child, nexts, offsets} =
      first_walk(
        root.left_child,
        depth + 1,
        nexts,
        offsets
      )

    {right_child, nexts, offsets} =
      first_walk(
        root.right_child,
        depth + 1,
        nexts,
        offsets
      )

    # update node with updated children
    root = %Node{root | left_child: left_child, right_child: right_child}
    width = Node.width(root)

    # find the nodes initial place. Might be adjusted later in the second walk.
    place =
      cond do
        Node.is_leaf?(root) ->
          Map.get(nexts, depth, 0)

        root.left_child == nil ->
          root.right_child.x - floor(width / 2)

        root.right_child == nil ->
          root.left_child.x + floor(width / 2)

        root.left_child != nil && root.right_child != nil ->
          floor((root.left_child.x + root.right_child.x + Node.width(root.right_child)) / 2) -
            floor(Node.width(root) / 2)
      end

    # update offsets map with the higher value between the currently known
    # offset, or the nexts - place value.
    offsets =
      Map.put(
        offsets,
        depth,
        max(
          Map.get(offsets, depth, 0),
          Map.get(nexts, depth, 0) - place
        )
      )

    # based on previous offsets and calculated place, determine
    # the new X position of the node for the first walk.
    new_x =
      if Node.is_leaf?(root) do
        place
      else
        place + Map.get(offsets, depth, 0)
      end

    # update node's position
    root = %Node{root | x: new_x, y: depth * 5, offset: Map.get(offsets, depth, 0)}

    nexts = Map.put(nexts, depth, new_x + Node.width(root))

    {root, nexts, offsets}
  end

  defp second_walk(node, nexts, depth \\ 0, modifier_sum \\ 0)

  defp second_walk(nil, nexts, _depth, _modifier_sum) do
    {nil, nexts}
  end

  defp second_walk(%Node{} = root, nexts, depth, modifier_sum) do
    root = %Node{root | x: root.x + modifier_sum}

    # recurse and calculate for left child first
    {left_child, nexts} =
      second_walk(
        root.left_child,
        nexts,
        depth + 1,
        modifier_sum + root.offset
      )

    {right_child, nexts} =
      second_walk(
        root.right_child,
        nexts,
        depth + 1,
        modifier_sum + root.offset
      )

    root = %Node{root | left_child: left_child, right_child: right_child}

    {root, nexts}
  end
end
