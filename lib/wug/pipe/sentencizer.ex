defmodule Wug.Pipe.Sentencizer do
  use Wug.Pipe

  alias Wug.Document

  @spec call(Document.t(), keyword()) :: Document.t()
  def call(doc, language: language) do
    language.sentencize(doc)
  end
end
