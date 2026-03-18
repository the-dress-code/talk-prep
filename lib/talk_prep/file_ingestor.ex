defmodule TalkPrep.FileIngestor do
  def read_file(file_path) do
    case File.read(file_path) do
      {:ok, content} ->
        {:ok, content}
      {:error, reason} ->
        {:error, reason}
    end
  end

  def process_file(file_path) do
    case read_file(file_path) do
      {:ok, content} ->
        IO.puts("Processing file: #{file_path}")
        # Placeholder implementation for processing file content
        :ok
      {:error, reason} ->
        IO.puts("Error reading file: #{file_path} - #{reason}")
        {:error, reason}
    end
  end
end
