defmodule Bintreeviz do
  @moduledoc """
  Bintreeviz is an Elixir implementation of the Wetherell and Shannon
  alhorithm as described in their 1979 publication of Tidy Drawings of Trees in
  IEEE.

  Its main purpose is to convert a given tree structure in a string representation
  of the tree using ASCII characters.
  """

  alias Bintreeviz.{
    Node,
    Positioner,
    AsciiRenderer
  }

  @doc "render/1 takes the root node, positions it and then renders it into a string"
  @spec render(Node.t()) :: String.t()
  def render(%Node{} = root) do
    root
    |> Positioner.position()
    |> AsciiRenderer.render()
  end

  def test do
    # other build options are:
    # - :simple
    # - :medium
    # - :large
    # - :weird
    Bintreeviz.Factory.build(:weird)
    |> render()
    |> IO.puts()
  end
end
