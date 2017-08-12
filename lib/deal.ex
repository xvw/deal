defmodule Deal do
  @moduledoc """
  Documentation for Deal.
  """

  @doc false 
  def __using__(_opts), do: quote do: import Deal

  defp fresh_name(index), do: String.to_atom("deal_#{index}")
  defp var(i), do: {fresh_name(i), [], __MODULE__}
  defp ok(i), do: {:ok, var(i)}
  defp clause(0, fun, xs), do: {:<-, [], [ok(1), {fun, [], xs}]}
  defp clause(i, fun, xs), do: {:<-, [], [ok(i+1), {fun, [], [var(i) | xs]}]}

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
