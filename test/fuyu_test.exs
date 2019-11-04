defmodule FuyuTest do
  use ExUnit.Case
  doctest Fuyu

  test "greets the world" do
    assert Fuyu.hello() == :world
  end
end
