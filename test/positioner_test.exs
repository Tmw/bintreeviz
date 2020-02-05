defmodule Bintreeviz.Positioner.Test do
  use ExUnit.Case
  import Bintreeviz.{Factory, TreeHelpers}
  alias Bintreeviz.Positioner

  describe "#position" do
    test "positions a simple binary tree" do
      tree = Positioner.position(build(:simple))

      tree |> assert_node_position("Root", 19, 0)
      tree |> assert_node_position("Node A", 6, 5)
      tree |> assert_node_position("Node B", 30, 5)
      tree |> assert_node_position("Node C", 0, 10)
      tree |> assert_node_position("Node D", 12, 10)
      tree |> assert_node_position("Node E", 24, 10)
      tree |> assert_node_position("Node F", 36, 10)
    end

    test "positions a medium binary tree" do
      tree = Positioner.position(build(:medium))

      tree |> assert_node_position("Node A", 24, 0)
      tree |> assert_node_position("Node B", 12, 5)
      tree |> assert_node_position("Node C", 36, 5)
      tree |> assert_node_position("Node D", 6, 10)
      tree |> assert_node_position("Node E", 18, 10)
      tree |> assert_node_position("Node F", 30, 10)
      tree |> assert_node_position("Node G", 42, 10)
      tree |> assert_node_position("Node H", 0, 15)
      tree |> assert_node_position("Node I", 12, 15)
    end

    test "positions a large binary tree" do
      tree = Positioner.position(build(:large))

      tree |> assert_node_position("Node A", 21, 0)
      tree |> assert_node_position("Node B", 6, 5)
      tree |> assert_node_position("Node C", 36, 5)
      tree |> assert_node_position("Node D", 0, 10)
      tree |> assert_node_position("Node E", 12, 10)
      tree |> assert_node_position("Node F", 24, 10)
      tree |> assert_node_position("Node G", 48, 10)
      tree |> assert_node_position("Node H", 18, 15)
      tree |> assert_node_position("Node I", 30, 15)
      tree |> assert_node_position("Node J", 42, 15)
      tree |> assert_node_position("Node K", 54, 15)
    end

    test "positions a weird binary tree" do
      tree = Positioner.position(build(:weird))

      tree |> assert_node_position("Node A", 18, 0)
      tree |> assert_node_position("Node B", 6, 5)
      tree |> assert_node_position("Node C", 30, 5)
      tree |> assert_node_position("Node D", 0, 10)
      tree |> assert_node_position("Node E", 12, 10)
      tree |> assert_node_position("Node F", 24, 10)
      tree |> assert_node_position("Node G", 36, 10)

      tree |> assert_node_position("Node H", 30, 15)
      tree |> assert_node_position("Node I", 42, 15)

      tree |> assert_node_position("Node J", 36, 20)
      tree |> assert_node_position("Node K", 42, 25)
      tree |> assert_node_position("Node L", 48, 30)
      tree |> assert_node_position("Node M", 54, 35)
    end
  end
end
