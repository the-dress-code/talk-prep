defmodule Mix.Tasks.Braindump do
  @moduledoc "Process a braindump file and print structured output."
  @shortdoc "Process a braindump file"

  use Mix.Task

  @impl Mix.Task
  def run([file_path]) do
    Mix.Task.run("app.start")

    case TalkPrep.BraindumpProcessor.process(file_path) do
      {:error, reason} ->
        Mix.shell().error("Error: #{reason}")

      result ->
        print_result(result)
    end
  end

  def run(_) do
    Mix.shell().error("Usage: mix braindump <path/to/file.txt>")
  end

  defp print_result(%{themes: themes, topics: topics}) do
    Mix.shell().info("\n=== Themes ===")

    Enum.each(themes, fn theme ->
      Mix.shell().info("  #{theme}")
    end)

    Mix.shell().info("\n=== Topics ===\n")

    Enum.each(topics, fn topic ->
      label = if topic.needs_points, do: " [needs points]", else: ""
      Mix.shell().info("#{topic.topic}#{label}")

      Enum.each(topic.points, fn point ->
        Mix.shell().info("  - #{point.point}")

        Enum.each(point.details, fn detail ->
          Mix.shell().info("      #{detail}")
        end)
      end)

      Mix.shell().info("")
    end)
  end
end
