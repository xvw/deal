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

  test "Simple deal use case" do
    result = Deal.with! do
      f(1)
      g()
      h()
    end
    assert result == {:ok, 6}
  end

  test "Deal with unexcepted pattern" do
    result = Deal.with! do
      f(1)
      i()
      h()
    end
    assert result == 7
  end

  test "Deal inlined" do
    result = Deal.with! do: (f(1); g(); h())
    assert result == {:ok, 6}
  end

  test "Deal inlined with unexcepted pattern" do
    result = Deal.with! do: (f(1); i(); h())
    assert result == 7
  end

  test "Deal with tuple" do
    result = Deal.with! do: {f(1), g(), h()}
    assert result == {:ok, 6}
  end

  test "Deal with tuple and unexcepted pattern" do
    result = Deal.with! do: {f(1), i(), h()}
    assert result == 7
  end


end
