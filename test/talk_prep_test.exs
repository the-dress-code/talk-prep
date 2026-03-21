defmodule TalkPrepTest do
  use ExUnit.Case
  doctest TalkPrep

  test "greets the world" do
    assert TalkPrep.hello() == :world
  end

  test "processes a braindump file" do
    file_path = "test/fixtures/sample_braindump.txt"
    assert File.exists?(file_path), "Sample braindump file does not exist"

    result = TalkPrep.BraindumpProcessor.process(file_path)
    assert is_map(result)
    assert Map.has_key?(result, :raw)
    assert Map.has_key?(result, :themes)
    assert Map.has_key?(result, :topics)
  end
end
