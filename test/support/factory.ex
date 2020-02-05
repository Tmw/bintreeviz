defmodule Bintreeviz.Factory do
  alias Bintreeviz.Node

  def build(:simple) do
    Node.new("Root",
      left_child:
        Node.new("Node A",
          left_child: Node.new("Node C"),
          right_child: Node.new("Node D")
        ),
      right_child:
        Node.new("Node B",
          left_child: Node.new("Node E"),
          right_child: Node.new("Node F")
        )
    )
  end

  def build(:medium) do
    Node.new("Node A",
      left_child:
        Node.new("Node B",
          left_child:
            Node.new("Node D",
              left_child: Node.new("Node H"),
              right_child: Node.new("Node I")
            ),
          right_child: Node.new("Node E")
        ),
      right_child:
        Node.new("Node C",
          left_child: Node.new("Node F"),
          right_child: Node.new("Node G")
        )
    )
  end

  def build(:large) do
    Node.new("Node A",
      left_child:
        Node.new("Node B",
          left_child: Node.new("Node D"),
          right_child: Node.new("Node E")
        ),
      right_child:
        Node.new("Node C",
          left_child:
            Node.new("Node F",
              left_child: Node.new("Node H"),
              right_child: Node.new("Node I")
            ),
          right_child:
            Node.new("Node G",
              left_child: Node.new("Node J"),
              right_child: Node.new("Node K")
            )
        )
    )
  end

  def build(:weird) do
    Node.new("Node A",
      left_child:
        Node.new("Node B",
          left_child: Node.new("Node D"),
          right_child: Node.new("Node E")
        ),
      right_child:
        Node.new("Node C",
          left_child: Node.new("Node F"),
          right_child:
            Node.new("Node G",
              left_child:
                Node.new("Node H",
                  left_child: nil,
                  right_child:
                    Node.new("Node J",
                      left_child: nil,
                      right_child:
                        Node.new("Node K",
                          left_child: nil,
                          right_child:
                            Node.new("Node L",
                              left_child: nil,
                              right_child: Node.new("Node M")
                            )
                        )
                    )
                ),
              right_child: Node.new("Node I")
            )
        )
    )
  end
end
