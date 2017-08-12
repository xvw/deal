defmodule Deal do
  @moduledoc """
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

  """

  @doc false
  def __using__(_opts), do: quote do: import Deal

  defp fresh_name(index), do: String.to_atom("deal_#{index}")
  defp var(i), do: {fresh_name(i), [], __MODULE__}
  defp ok(i), do: {:ok, var(i)}
  defp clause(0, fun, xs), do: {:<-, [], [ok(1), {fun, [], xs}]}
  defp clause(i, fun, xs), do: {:<-, [], [ok(i+1), {fun, [], [var(i) | xs]}]}


  @doc """
  The macro provide a simple way to chain function that returns `{:ok, value}`.

  For example :

      iex> Deal.with! do
      ...>   f(10)
      ...>   g()
      ...>   h()
      ...> end
      {:ok, 6}

  This code is translated into this form :

  ```elixir
  with
    {:ok, deal_1} -> f(1),
    {:ok, deal_2} -> g(deal_1),
    {:ok, deal_3} -> h(deal_2),
  do: {:ok, deal_3}
  ```

  """
  defmacro with!(block)
  defmacro with!(do: {:__block__, _, expr}) do
    {i, expr_body} = expr
    |> Enum.reduce({0, []},
    fn(value, {i, acc}) ->
      case value do
        {fun, _, xs} -> {i+1, [clause(i, fun, xs) | acc]}
      end
    end)
    clauses = [[do: ok(i)]| expr_body ]
    new_expr = {:with, [], Enum.reverse clauses}
    quote bind_quoted: [new_expr: new_expr], do: new_expr
  end


end
