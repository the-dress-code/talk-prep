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
        - "raw": the original text as a string, unchanged
        - "themes": a list of strings, each a specific concept or idea from the text. Use concrete terms like "immutability", "REPL feedback loop", "minimal syntax" — not broad categories like "learning process" or "community". Extract all of them.
        - "topics": a list of objects. Use these definitions:
          - A TOPIC is a grouping or theme that holds related ideas together. It can be a fragment or label. A topic can stand alone with no points.
          - A POINT is a direct statement or assertion from the braindump that belongs under a topic. A point can stand alone with no details.
          - A DETAIL is a specific example, elaboration, or sub-item that belongs under a point.

          Each topic object has:
          - "topic": the grouping label or theme (string, use the speaker's own words)
          - "points": a list of point objects under this topic (can be empty). Each point object has:
            - "point": the statement or assertion (string, use the speaker's own words)
            - "details": a list of strings, each a specific example or elaboration under this point (can be empty)
          - "needs_points": true if the topic has no points and would benefit from elaboration, false otherwise

        Rules:
        - Extract every topic — do not skip any.
        - Do not add interpretation or ideas not present in the text.
        - If no topics are found, return "topics" as an empty list.
        - Return ONLY the JSON object. No explanation, no markdown, no code fences.

        Braindump text:
        #{content}
        """

        {:ok, response} = ReqLLM.generate_text(model, prompt, api_key: "ollama", receive_timeout: 300_000)

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
         "topics" => topics
       }} ->
        %{
          raw: raw,
          themes: themes,
          topics:
            Enum.map(topics, fn topic ->
              %{
                topic: topic["topic"],
                needs_points: topic["needs_points"],
                points:
                  Enum.map(topic["points"] || [], fn point ->
                    %{
                      point: point["point"],
                      details: point["details"] || []
                    }
                  end)
              }
            end)
        }

      {:error, _} ->
        {:error, "Invalid response format from Qwen model"}
    end
  end
  def topics_with_no_points(%{topics: topics}) do
    Enum.filter(topics, fn topic -> topic.points == [] end)
  end

end
