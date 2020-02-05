defmodule Bintreeviz.Node do
  @padding 4
  @margin 2

  defstruct label: nil,
            x: 0,
            y: 0,
            offset: 0,
            parent: nil,
            left_child: nil,
            right_child: nil

  alias __MODULE__

  def new(label) when is_binary(label) do
    %Node{label: label}
  end

  def new(label, left_child: %Node{} = left_child, right_child: %Node{} = right_child)
      when is_binary(label) do
    label
    |> new()
    |> set_left_child(left_child)
    |> set_right_child(right_child)
  end

  def new(label, left_child: nil, right_child: %Node{} = right_child) when is_binary(label) do
    label
    |> new()
    |> set_right_child(right_child)
  end

  def new(label, left_child: %Node{} = left_child, right_child: nil) when is_binary(label) do
    label
    |> new()
    |> set_left_child(left_child)
  end

  def new(label, left_child: nil, right_child: nil) do
    new(label)
  end

  def set_left_child(%Node{} = self, %Node{} = child) do
    %Node{self | left_child: Node.set_parent(child, self)}
  end

  def set_right_child(%Node{} = self, %Node{} = child) do
    %Node{self | right_child: Node.set_parent(child, self)}
  end

  def width(%Node{label: label}) do
    String.length(label) + @padding + @margin
  end

  def set_parent(%Node{} = self, %Node{} = parent) do
    %Node{self | parent: parent}
  end

  @doc """
  is_leaf/1 returns true if the node has no left_child and no right_child.
  """

  def is_leaf?(%Node{left_child: nil, right_child: nil}), do: true
  def is_leaf?(%Node{} = _root), do: false
end
