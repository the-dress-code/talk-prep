defmodule TalkPrep.FileIngestor do
  def read_file(file_path) do
    case File.read(file_path) do
      {:ok, content} ->
        {:ok, content}

      {:error, reason} ->
        {:error, reason}
    end
  end
end
