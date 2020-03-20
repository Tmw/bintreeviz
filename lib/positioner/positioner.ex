defmodule Bintreeviz.Positioner do
  @moduledoc """
  Bintreeviz.Positioner describes the behaviour for implementing a positioner. Out of the box Bintreeviz will provide the WS implementation. Implementing another positioner is as easy as providing a module with a `position/1` function which will take the root node and returns the fully positioned root node.
  """
  @callback position(Node.t()) :: Node.t()
end
