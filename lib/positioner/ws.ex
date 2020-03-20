defmodule Bintreeviz.Positioner.WS do
  @moduledoc """
  Module to do the positioning following the WS algorithm. As described in the original paper,
  this algorithm works with two loops to keep the algorithm performing in O(N).
  """

  @behaviour Bintreeviz.Positioner
  # internal struct to keep track of positioning walk results
  defmodule WalkResult do
    @moduledoc false
    defstruct node: nil, nexts: nil, offsets: nil
  end

  @margin 2
  @node_height 4
  alias Bintreeviz.Node

  @doc "position/1 takes the root node and positions it and all its child nodes accordingly"
  @spec position(Node.t()) :: Node.t()
  @impl true
  def position(%Node{} = root) do
    %WalkResult{node: node} =
      root
      |> first_walk()
      |> second_walk()

    node
  end

  @spec first_walk(Node.t(), non_neg_integer(), map(), map()) :: {Node.t(), map(), map()}
  defp first_walk(root, depth \\ 0, nexts \\ %{}, offsets \\ %{})

  defp first_walk(nil, _depth, nexts, offsets),
    do: %WalkResult{node: nil, nexts: nexts, offsets: offsets}

  defp first_walk(%Node{} = root, depth, nexts, offsets) do
    %WalkResult{node: left_child, nexts: nexts, offsets: offsets} =
      first_walk(
        root.left_child,
        depth + 1,
        nexts,
        offsets
      )

    %WalkResult{node: right_child, nexts: nexts, offsets: offsets} =
      first_walk(
        root.right_child,
        depth + 1,
        nexts,
        offsets
      )

    # update node with updated children
    root = %Node{root | left_child: left_child, right_child: right_child}
    root_width = Node.width(root) + @margin

    # find the nodes initial position. This might be overwritten in the second
    # walk due to children shifting its parent position.
    preliminary_x = get_preliminary_x(root, nexts, depth)

    # update offsets map with the higher value between the currently known
    # offset, or the nexts - preliminary_x value.
    bigger_offset = max(Map.get(offsets, depth, 0), Map.get(nexts, depth, 0) - preliminary_x)
    offsets = Map.put(offsets, depth, bigger_offset)

    # based on previous offsets and calculated preliminary_x, determine
    # the new preliminary x position of the node for the first walk.
    preliminary_x =
      case Node.is_leaf?(root) do
        true -> preliminary_x
        false -> preliminary_x + Map.get(offsets, depth, 0)
      end

    # update node's position
    root = %Node{
      root
      | x: preliminary_x,
        y: depth * @node_height,
        offset: Map.get(offsets, depth, 0)
    }

    # update nexts
    nexts = Map.put(nexts, depth, preliminary_x + root_width)

    %WalkResult{
      node: root,
      nexts: nexts,
      offsets: offsets
    }
  end

  defp get_preliminary_x(%Node{} = root, nexts, depth) do
    root_width = Node.width(root) + @margin

    case root do
      %Node{left_child: nil, right_child: nil} ->
        Map.get(nexts, depth, 0)

      %Node{left_child: nil, right_child: %Node{} = right_child} ->
        right_child.x - floor(root_width / 2)

      %Node{left_child: %Node{} = left_child, right_child: nil} ->
        left_child.x + floor(root_width / 2)

      %Node{left_child: %Node{} = left_child, right_child: %Node{} = right_child} ->
        floor((left_child.x + right_child.x + Node.width(right_child) + @margin) / 2) -
          floor(root_width / 2)
    end
  end

  @spec second_walk(WalkResult.t()) :: WalkResult.t()
  defp second_walk(%WalkResult{node: root, nexts: nexts}), do: second_walk(root, nexts)

  @spec second_walk(Node.t(), map(), non_neg_integer()) :: WalkResult.t()
  defp second_walk(node, nexts, depth \\ 0, modifier_sum \\ 0)
  defp second_walk(nil, nexts, _depth, _modifier_sum), do: %WalkResult{node: nil, nexts: nexts}

  defp second_walk(%Node{} = root, nexts, depth, modifier_sum) do
    # recurse and calculate for left child first
    %WalkResult{node: left_child, nexts: nexts} =
      second_walk(
        root.left_child,
        nexts,
        depth + 1,
        modifier_sum + root.offset
      )

    # then calculate for the right child
    %WalkResult{node: right_child, nexts: nexts} =
      second_walk(
        root.right_child,
        nexts,
        depth + 1,
        modifier_sum + root.offset
      )

    # then combine results
    root = %Node{
      root
      | left_child: left_child,
        right_child: right_child,
        x: root.x + modifier_sum
    }

    %WalkResult{nexts: nexts, node: root}
  end
end
