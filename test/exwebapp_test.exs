defmodule ExwebappTest do
  use ExUnit.Case
  doctest Exwebapp

  test "greets the world" do
    assert Exwebapp.hello() == :world
  end
end
