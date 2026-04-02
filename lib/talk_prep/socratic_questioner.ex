defmodule TalkPrep.SocraticQuestioner do
  @moduledoc """
  Socratic questioner — questions unsupported claims in a braindump.
  See AGENTS.md for feature contract pointer.
  """

  def build_first_question(_claim) do
    raise "not implemented"
  end

  def build_followup(_claim, _answer) do
    raise "not implemented"
  end

  def new_session do
    raise "not implemented"
  end

  def add_claim_to_session(_session, _claim_exchange) do
    raise "not implemented"
  end

  def save_session(_session) do
    raise "not implemented"
  end
end
