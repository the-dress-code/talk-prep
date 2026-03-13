defmodule TalkPrepTest do
  use ExUnit.Case
  doctest TalkPrep

  test "greets the world" do
    assert TalkPrep.hello() == :world
  end
end
