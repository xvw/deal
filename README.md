Deal is, at the moment, not realsed (on hex).

# Deal

This module is not about Monad or Maybe... it is just a shortcut
over the pattern `{:ok, value}`.

With **Deal**, you can write code like that:


```elixir
Deal.with! do
  f(1)
  g()
  h()
end
```

instead of:

```elixir
with
    {:ok, a} -> f(1),
    {:ok, b} -> g(a),
    {:ok, c} -> h(b),
do: {:ok, c}
```

You can checkout the [test file](test/deal_test.exs) for more examples.

## Installation

The package can be installed
by adding `deal` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:deal, "~> 1.0.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/deal](https://hexdocs.pm/deal).
