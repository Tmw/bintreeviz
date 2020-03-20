![](https://github.com/tmw/bintreevis/workflows/Elixir%20CI/badge.svg)

# 🌳 Bintreeviz

Bintreeviz is an Elixir implementation of the Wetherell and Shannon
alhorithm as described in their 1979 publication of Tidy Drawings of Trees in
IEEE.

## Example

Building the tree
```elixir
alias Bintreeviz.Node

root = Node.new("Root",
  left_child: Node.new("Node A",
    left_child: Node.new("Node C"),
    right_child: Node.new("Node D")
  ),
  right_child: Node.new("Node B",
    left_child: Node.new("Node E"),
    right_child: Node.new("Node F")
  )
)

```

Rendering the tree
```elixir
root
|> Bintreeviz.render()
|> IO.puts()
```

The result:
```text
                   ┏━━━━━━┓
                   ┃ Root ┃
                   ┗━━━┳━━┛
           ┏━━━━━━━━━━━┻━━━━━━━━━━━┓
      ┏━━━━┻━━━┓              ┏━━━━┻━━━┓
      ┃ Node A ┃              ┃ Node B ┃
      ┗━━━━┳━━━┛              ┗━━━━┳━━━┛
     ┏━━━━━┻━━━━━┓           ┏━━━━━┻━━━━━┓
┏━━━━┻━━━┓  ┏━━━━┻━━━┓  ┏━━━━┻━━━┓  ┏━━━━┻━━━┓
┃ Node C ┃  ┃ Node D ┃  ┃ Node E ┃  ┃ Node F ┃
┗━━━━━━━━┛  ┗━━━━━━━━┛  ┗━━━━━━━━┛  ┗━━━━━━━━┛
```

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `bintreeviz` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:bintreeviz, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/bintreeviz](https://hexdocs.pm/bintreeviz).
