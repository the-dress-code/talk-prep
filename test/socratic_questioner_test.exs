defmodule TalkPrep.SocraticQuestionerTest do
  use ExUnit.Case

  alias TalkPrep.SocraticQuestioner

  # ---------------------------------------------------------------------------
  # Exchange shape
  # ---------------------------------------------------------------------------

  describe "build_first_question/1" do
    test "returns a non-empty question string for a valid claim" do
      claim = "Vanilla ice cream is best on a hot day"
      question = SocraticQuestioner.build_first_question(claim)
      assert is_binary(question)
      assert String.length(question) > 0
    end

    test "raises on empty claim" do
      assert_raise ArgumentError, fn ->
        SocraticQuestioner.build_first_question("")
      end
    end
  end

  describe "build_followup/2" do
    test "returns a non-empty follow-up question given a claim and prior answer" do
      claim = "Vanilla ice cream is best on a hot day"
      answer = "It tastes good and doesn't stain your shirt"
      followup = SocraticQuestioner.build_followup(claim, answer)
      assert is_binary(followup)
      assert String.length(followup) > 0
    end
  end

  # ---------------------------------------------------------------------------
  # Session structure
  # ---------------------------------------------------------------------------

  describe "new_session/0" do
    test "returns a map with an empty claims list" do
      session = SocraticQuestioner.new_session()
      assert %{claims: []} = session
    end
  end

  describe "add_claim_to_session/2" do
    test "appends a completed claim exchange to the session" do
      session = SocraticQuestioner.new_session()
      claim_exchange = %{
        claim: "Vanilla is best",
        exchanges: [%{question: "Why?", answer: "It doesn't stain."}]
      }
      updated = SocraticQuestioner.add_claim_to_session(session, claim_exchange)
      assert length(updated.claims) == 1
      assert hd(updated.claims).claim == "Vanilla is best"
    end
  end

  # ---------------------------------------------------------------------------
  # Storage
  # ---------------------------------------------------------------------------

  describe "save_session/1" do
    test "writes a JSON file to the sessions/ directory" do
      session = %{
        claims: [
          %{
            claim: "Vanilla is best",
            exchanges: [%{question: "Why?", answer: "It doesn't stain."}]
          }
        ]
      }
      {:ok, path} = SocraticQuestioner.save_session(session)
      assert File.exists?(path)
      assert String.starts_with?(path, "sessions/")
      assert String.ends_with?(path, ".json")
      File.rm!(path)
    end

    test "filename matches timestamp pattern socratic_YYYY-MM-DDTHH-MM.json" do
      session = %{
        claims: [%{claim: "Test", exchanges: [%{question: "Q", answer: "A"}]}]
      }
      {:ok, path} = SocraticQuestioner.save_session(session)
      filename = Path.basename(path)
      assert Regex.match?(~r/^socratic_\d{4}-\d{2}-\d{2}T\d{2}-\d{2}\.json$/, filename)
      File.rm!(path)
    end

    test "returns :no_op when session has no completed claims" do
      session = SocraticQuestioner.new_session()
      assert :no_op = SocraticQuestioner.save_session(session)
    end

    test "saved JSON is valid and contains claim data" do
      session = %{
        claims: [
          %{
            claim: "Vanilla is best",
            exchanges: [%{question: "Why?", answer: "It doesn't stain."}]
          }
        ]
      }
      {:ok, path} = SocraticQuestioner.save_session(session)
      contents = File.read!(path)
      parsed = JSON.decode!(contents)
      assert is_list(parsed["claims"])
      assert hd(parsed["claims"])["claim"] == "Vanilla is best"
      File.rm!(path)
    end
  end
end
