defmodule Bintreeviz.Positioner.WS.Test do
  use ExUnit.Case
  import Bintreeviz.{Factory, TreeHelpers}
  alias Bintreeviz.Positioner.WS, as: Positioner

  describe "#position" do
    test "positions a simple binary tree" do
      tree = Positioner.position(build(:simple))

      tree |> assert_node_position("Root", 19, 0)
      tree |> assert_node_position("Node A", 6, 6)
      tree |> assert_node_position("Node B", 30, 6)
      tree |> assert_node_position("Node C", 0, 12)
      tree |> assert_node_position("Node D", 12, 12)
      tree |> assert_node_position("Node E", 24, 12)
      tree |> assert_node_position("Node F", 36, 12)
    end

    test "positions a medium binary tree" do
      tree = Positioner.position(build(:medium))

      tree |> assert_node_position("Node A", 24, 0)
      tree |> assert_node_position("Node B", 12, 6)
      tree |> assert_node_position("Node C", 36, 6)
      tree |> assert_node_position("Node D", 6, 12)
      tree |> assert_node_position("Node E", 18, 12)
      tree |> assert_node_position("Node F", 30, 12)
      tree |> assert_node_position("Node G", 42, 12)
      tree |> assert_node_position("Node H", 0, 18)
      tree |> assert_node_position("Node I", 12, 18)
    end

    test "positions a large binary tree" do
      tree = Positioner.position(build(:large))

      tree |> assert_node_position("Node A", 21, 0)
      tree |> assert_node_position("Node B", 6, 6)
      tree |> assert_node_position("Node C", 36, 6)
      tree |> assert_node_position("Node D", 0, 12)
      tree |> assert_node_position("Node E", 12, 12)
      tree |> assert_node_position("Node F", 24, 12)
      tree |> assert_node_position("Node G", 48, 12)
      tree |> assert_node_position("Node H", 18, 18)
      tree |> assert_node_position("Node I", 30, 18)
      tree |> assert_node_position("Node J", 42, 18)
      tree |> assert_node_position("Node K", 54, 18)
    end

    test "positions a weird binary tree" do
      tree = Positioner.position(build(:weird))

      tree |> assert_node_position("Node A", 18, 0)
      tree |> assert_node_position("Node B", 6, 6)
      tree |> assert_node_position("Node C", 30, 6)
      tree |> assert_node_position("Node D", 0, 12)
      tree |> assert_node_position("Node E", 12, 12)
      tree |> assert_node_position("Node F", 24, 12)
      tree |> assert_node_position("Node G", 36, 12)

      tree |> assert_node_position("Node H", 30, 18)
      tree |> assert_node_position("Node I", 42, 18)

      tree |> assert_node_position("Node J", 36, 24)
      tree |> assert_node_position("Node K", 42, 30)
      tree |> assert_node_position("Node L", 48, 36)
      tree |> assert_node_position("Node M", 54, 42)
    end
  end
end
