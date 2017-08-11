defmodule DealTest do
  use ExUnit.Case
  doctest Deal

  test "greets the world" do
    assert Deal.hello() == :world
  end
end
