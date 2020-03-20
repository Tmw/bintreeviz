defmodule Bintreeviz.Positioner.WS.Test do
  use ExUnit.Case
  import Bintreeviz.{Factory, TreeHelpers}
  alias Bintreeviz.Positioner.WS, as: Positioner

  describe "#position" do
    test "positions a simple binary tree" do
      tree = Positioner.position(build(:simple))

      tree |> assert_node_position("Root", 19, 0)
      tree |> assert_node_position("Node A", 6, 4)
      tree |> assert_node_position("Node B", 30, 4)
      tree |> assert_node_position("Node C", 0, 8)
      tree |> assert_node_position("Node D", 12, 8)
      tree |> assert_node_position("Node E", 24, 8)
      tree |> assert_node_position("Node F", 36, 8)
    end

    test "positions a medium binary tree" do
      tree = Positioner.position(build(:medium))

      tree |> assert_node_position("Node A", 24, 0)
      tree |> assert_node_position("Node B", 12, 4)
      tree |> assert_node_position("Node C", 36, 4)
      tree |> assert_node_position("Node D", 6, 8)
      tree |> assert_node_position("Node E", 18, 8)
      tree |> assert_node_position("Node F", 30, 8)
      tree |> assert_node_position("Node G", 42, 8)
      tree |> assert_node_position("Node H", 0, 12)
      tree |> assert_node_position("Node I", 12, 12)
    end

    test "positions a large binary tree" do
      tree = Positioner.position(build(:large))

      tree |> assert_node_position("Node A", 21, 0)
      tree |> assert_node_position("Node B", 6, 4)
      tree |> assert_node_position("Node C", 36, 4)
      tree |> assert_node_position("Node D", 0, 8)
      tree |> assert_node_position("Node E", 12, 8)
      tree |> assert_node_position("Node F", 24, 8)
      tree |> assert_node_position("Node G", 48, 8)
      tree |> assert_node_position("Node H", 18, 12)
      tree |> assert_node_position("Node I", 30, 12)
      tree |> assert_node_position("Node J", 42, 12)
      tree |> assert_node_position("Node K", 54, 12)
    end

    test "positions a weird binary tree" do
      tree = Positioner.position(build(:weird))

      tree |> assert_node_position("Node A", 18, 0)
      tree |> assert_node_position("Node B", 6, 4)
      tree |> assert_node_position("Node C", 30, 4)
      tree |> assert_node_position("Node D", 0, 8)
      tree |> assert_node_position("Node E", 12, 8)
      tree |> assert_node_position("Node F", 24, 8)
      tree |> assert_node_position("Node G", 36, 8)

      tree |> assert_node_position("Node H", 30, 12)
      tree |> assert_node_position("Node I", 42, 12)

      tree |> assert_node_position("Node J", 36, 16)
      tree |> assert_node_position("Node K", 42, 20)
      tree |> assert_node_position("Node L", 48, 24)
      tree |> assert_node_position("Node M", 54, 28)
    end
  end
end
