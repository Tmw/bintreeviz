defmodule Bintreeviz.Renderer do
  @moduledoc """
  Bintreeviz.Renderer describes the behaviour for implementing a renderer. Out of the box Bintreeviz will provide a ASCII renderer which will turn the provided graph into a stringified representation using configurable box drawing characters.
  """
  @callback render(Node.t()) :: String.t()
end
