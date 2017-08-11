defmodule DealTest do
  use ExUnit.Case
  doctest Deal

  # test "greets the world" do
  #   assert Deal.hello() == :world
  # end

  def f(x), do: {:ok, x}
  def g(x), do: {:ok, x}

  test "Un test" do
    import Deal

    
    x = with! do
      43
      f()
      g()
    end

    IO.inspect x

    
  end

  
end
