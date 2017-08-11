defmodule Deal do
  @moduledoc """
  Documentation for Deal.
  """

  @doc false 
  def __using__(_opts), do: quote do: import Deal

  defp fresh_name(index) do
    String.to_atom("deal_#{index}")
  end

  defp binded_variable(i) do
    {fresh_name(i), [], __MODULE__}
  end

  defp simple_binding(index, literal, acc) do
    mod = __MODULE__
    [{:=, [], [{fresh_name(index), [], mod}, literal]} | acc]
  end

  defp ok(i) do
    {:ok, binded_variable(i)}
  end

  defp clause(i, fun, xs) do
    {:<-, [], [ok(i+1), {fun, [], [binded_variable(i) | xs]}]}
  end

  defp first_with(i, fun, xs, acc) do
    [{:with, [], clause(i, fun, xs)} | acc]
  end

  defmacro with!(do: {:__block__, _, expr}) do
    {_, expr_body} = expr
    |> Enum.reduce({0, []}, 
    fn(value, {i, acc}) ->
      case {value, acc} do
        {{fun, _, xs}, [_binding]} -> {i+1, first_with(i, fun, xs, acc)}
        {{fun, _, xs}, [_, _|_]} -> {i+1, [clause(i, fun, xs) | acc]}          
        {literal, []} -> {i, simple_binding(i, literal, acc)}
      end
    end)
    new_expr = {:__block__, [], Enum.reverse(expr_body)}
    IO.inspect (Macro.to_string new_expr)
    quote bind_quoted: [new_expr: new_expr], do: new_expr
  end 
  

end
