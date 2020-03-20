defmodule Bintreeviz do
  @moduledoc """
  Bintreeviz is a binary tree visualizer for Elixir. Its main purpose is to convert a given tree structure into a string representation.

  ## Positioning
  It supports pluggable algorithms for positioning of the individual nodes. Out-of-the-box it comeswith the Wetherell and Shannon (WS) algorithm for drawing tidy trees as described in IEEE.

  ## Rendering
  It supports pluggable renderers for outputting the positioned tree to a string format. out-of-the-box it comes with an ASCII renderer which will use a configurable charset to draw the tree.

  ## Configuration options
  The renderer takes a keyword list with configuration options:

  * `renderer`
  Which renderer to use. It will default to the ASCII renderer which will render the tree using [Box Drawing Characters](https://en.wikipedia.org/wiki/Box-drawing_character) and can be printed to stdout as shown in the examples.

  * `positioner`
  Which positioning algorithm to use. It defaults to Wetherell and Shannon (WS).

  * `ascii_charset`
  Renderer specific configuration to configure which charset to use while rendering using the ASCII renderer.
  """

  alias Bintreeviz.{
    Node,
    Positioner,
    Positioner,
    Renderer
  }

  @type render_options :: [
          renderer: Renderer.t(),
          positioner: Positioner.t()
        ]

  @default_options [
    renderer: Renderer.Ascii,
    positioner: Positioner.WS,
    ascii_renderer_charset: Renderer.Ascii.Charset.BoxDrawingChars
  ]

  @doc "render/1 takes the root node, positions it and then renders it into a string"
  @spec render(Node.t(), render_options()) :: String.t()
  def render(%Node{} = root, options \\ @default_options) do
    renderer = Keyword.get(options, :renderer)
    positioner = Keyword.get(options, :positioner)

    root
    |> positioner.position()
    |> renderer.render(options)
  end
end
