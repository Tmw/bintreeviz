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
    Renderer
  }

  @type render_options :: [renderer: Renderer.t()] | nil
  @default_options [
    renderer: Renderer.Ascii
  ]

  @doc "render/1 takes the root node, positions it and then renders it into a string"
  @spec render(Node.t(), render_options()) :: String.t()
  def render(%Node{} = root, options \\ @default_options) do
    renderer = get_renderer(options)

    root
    |> Positioner.position()
    |> renderer.render()
  end

  defp get_renderer(renderer: renderer), do: renderer
end
