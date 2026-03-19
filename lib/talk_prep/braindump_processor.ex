defmodule TalkPrep.BraindumpProcessor do
  @moduledoc """
  This module processes braindumps by sending the text to the local Qwen model.
  """

  def process(file_path) do
    case TalkPrep.FileIngestor.read_file(file_path) do
      {:ok, content} ->
        model = ReqLLM.model!(%{id: "qwen2.5-coder:14b", provider: :openai, base_url: "http://localhost:11434/v1"})
        prompt = "Please process the following braindump and return the response as JSON: #{content}"
        {:ok, response} = ReqLLM.generate_text(model, prompt)

        parse_response(response)

      {:error, reason} ->
        {:error, reason}
    end
  end

  defp parse_response(response) do
    case Jason.decode(response) do
      {:ok, %{
        "raw" => raw,
        "themes" => themes,
        "claims" => claims,
        "summary" => summary
      }} ->
        %{
          raw: raw,
          themes: themes,
          claims: Enum.map(claims, fn claim ->
            %{
              claim: claim["claim"],
              support: claim["support"]
            }
          end),
          summary: summary
        }

      {:error, _} ->
        {:error, "Invalid response format from Qwen model"}
    end
  end
end
