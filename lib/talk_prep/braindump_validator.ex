defmodule TalkPrep.BraindumpValidator do
  def validate(braindump) do
    if is_binary(braindump) and String.length(braindump) > 0 do
      :ok
    else
      {:error, "Invalid braindump: must be a non-empty string"}
    end
  end
end
