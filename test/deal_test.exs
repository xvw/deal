defmodule DealTest do
  use ExUnit.Case
  doctest Deal

  # test "greets the world" do
  #   assert Deal.hello() == :world
  # end

  def f(x), do: {:ok, x}
  def g(x), do: {:ok, x+1}
  def h(x), do: {:ok, x+3}

  test "Un test" do

    
    x = Deal.with! do
      1 |> f()
      g()
      h()
    end

    assert x == {:ok, 5}
    

    
  end

  
end
