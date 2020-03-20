defmodule IexSession do
  @doc """
  test/1 renders an example tree. Possible tree_type values: `:simple, :medium, :large, :weird` 
  """
  def test(tree_type \\ :weird) do
    tree_type
    |> Bintreeviz.Factory.build()
    |> Bintreeviz.render()
    |> IO.puts()
  end
end
