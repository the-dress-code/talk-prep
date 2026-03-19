defmodule TalkPrep.BraindumpProcessor do
  @moduledoc """
  This module processes braindumps by sending the text to the local Qwen model.
  """

  def process(file_path) do
    case TalkPrep.FileIngestor.read_file(file_path) do
      {:ok, content} ->
        model =
          ReqLLM.model!(%{
            id: "qwen2.5-coder:14b",
            provider: :openai,
            base_url: "http://localhost:11434/v1"
          })

        prompt = """
        Analyze the following braindump text and return ONLY a JSON object with exactly these keys:
        - "raw": the original text as a string
        - "themes": a list of strings, each a broad topic the text is about
        - "claims": a list of objects, each with "claim" (a string assertion) and "support" (a list of strings that back it up)
        - "summary": a one paragraph summary of the text as a string

        If no claims are found, return "claims" as an empty list.
        Return ONLY the JSON object. No explanation, no markdown, no code fences.

        Braindump text:
        #{content}
        """

        {:ok, response} = ReqLLM.generate_text(model, prompt, api_key: "ollama")

        parse_response(ReqLLM.Response.text(response))

      {:error, reason} ->
        {:error, reason}
    end
  end

  defp parse_response(response) do
    cleaned =
      response
      |> String.replace(~r/```json\n?/, "")
      |> String.replace(~r/```/, "")
      |> String.trim()

    case Jason.decode(cleaned) do
      {:ok,
       %{
         "raw" => raw,
         "themes" => themes,
         "claims" => claims,
         "summary" => summary
       }} ->
        %{
          raw: raw,
          themes: themes,
          claims:
            Enum.map(claims, fn claim ->
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
