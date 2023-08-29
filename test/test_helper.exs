ExUnit.start()

defmodule TestLanguage do
  alias Wug.DefaultSentencizer
  alias Wug.NaiveTokenizer
  alias Wug.Document

  @behaviour Wug.Language

  @punctuation ~w|. ? ! , ; ' " ( )|

  @spec sentencize(Document.t(), Keyword.t()) :: Document.t()
  def sentencize(doc, _opts \\ []) do
    DefaultSentencizer.sentencize(doc)
  end

  @spec tokenize(Document.t(), Keyword.t()) :: Document.t()
  def tokenize(doc, _opts \\ []) do
    NaiveTokenizer.tokenize(doc, punctuation: @punctuation)
  end
end
