defmodule Bintreeviz.Node do
  @moduledoc """
  Bintreeviz.Node describes a single Node in the graph and contains the functions
  to manipulate said Nodes.
  """

  @padding 4

  alias __MODULE__

  @type t() :: %Node{
          label: String.t(),
          x: non_neg_integer(),
          y: non_neg_integer(),
          offset: integer(),
          left_child: Node.t(),
          right_child: Node.t()
        }

  defstruct label: nil,
            x: 0,
            y: 0,
            offset: 0,
            left_child: nil,
            right_child: nil

  @doc "new/1 takes a string label and returns a new %Node{}"
  @spec new(String.t()) :: Node.t()
  def new(label) when is_binary(label) do
    %Node{label: label}
  end

  @doc """
  new/2 takes a string label and an  Keyword list containing left and right
  children and returns a new  %Node{}
  """
  @type node_children :: [
          left_child: Node.t() | nil,
          right_child: Node.t() | nil
        ]
  @spec new(String.t(), node_children()) :: Node.t()
  def new(label, options)

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

  def new(label, left_child: nil, right_child: nil), do: new(label)

  @doc "set_left_child/2 assigns the passed in node as the left_child to the node."
  @spec set_left_child(Node.t(), Node.t()) :: Node.t()
  def set_left_child(%Node{} = self, %Node{} = child) do
    %Node{self | left_child: child}
  end

  @doc "set_right_child/2 assigns the passed in node as the right_child to the node."
  @spec set_right_child(Node.t(), Node.t()) :: Node.t()
  def set_right_child(%Node{} = self, %Node{} = child) do
    %Node{self | right_child: child}
  end

  @doc """
  width/1 returns the width of the node. Width of the node is determined by the
  length of the label plus the configured padding for the nodes.
  """
  @spec width(Node.t()) :: non_neg_integer()
  def width(%Node{label: label}) do
    String.length(label) + @padding
  end

  @doc """
  is_leaf/1 returns true if the node has no left_child and no right_child.
  """
  @spec is_leaf?(Node.t()) :: boolean()
  def is_leaf?(%Node{left_child: nil, right_child: nil}), do: true
  def is_leaf?(%Node{} = _root), do: false
end
