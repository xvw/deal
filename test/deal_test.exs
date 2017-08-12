defmodule DealTest do
  use ExUnit.Case
  doctest Deal

  # test "greets the world" do
  #   assert Deal.hello() == :world
  # end

  def f(x), do: {:ok, x}
  def g(_), do: {:ok, 3}
  def h(x), do: {:ok, x+3}
  def i(x), do: x+6

  test "Un test" do

    
    x = Deal.with! do
      1 |> f(); g(); h()
    end

    IO.inspect x

    # assert x == {:ok, 6}


    
  end

  
end
