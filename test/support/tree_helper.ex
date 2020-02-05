defmodule Bintreeviz.TreeHelpers do
  alias Bintreeviz.Node

  @moduledoc """
  Helper functions to run assertions against the tree structure(s).
  """

  # Helper function to traverse the tree and find the first node with the given
  # label. Node: This requires the node labels to be unique in the tree.
  def find_node_labeled(%Node{label: label} = node, label), do: {:ok, node}
  def find_node_labeled(nil, _label), do: nil

  def find_node_labeled(%Node{} = root, label) do
    left_node_res = find_node_labeled(root.left_child, label)
    right_node_res = find_node_labeled(root.right_child, label)

    cond do
      left_node_res != nil -> left_node_res
      right_node_res != nil -> right_node_res
      true -> nil
    end
  end

  # find the node by its label and assert its position against the
  # passed in X and Y values.
  def assert_node_position(root, label, x, y) do
    case find_node_labeled(root, label) do
      {:ok, node} -> assert_position(node, x, y)
      {:error, error} -> raise ExUnit.AssertionError, message: error
    end
  end

  # Assertion helpers to assert the Node's X and Y values against
  # the X and Y values passed in.
  def assert_position(%Node{x: x, y: y} = node, x, y), do: node

  def assert_position(%Node{x: x1, y: y1} = node, x2, y2) do
    raise ExUnit.AssertionError,
      message: "Location for node #{node.label} is faulty.
    Expected x = #{x2}, y = #{y2},
    Got: x = #{x1}, y = #{y1}."
  end
end
