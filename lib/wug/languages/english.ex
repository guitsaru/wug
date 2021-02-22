defmodule Wug.Languages.English do
  alias Wug.DefaultSentencizer
  alias Wug.NaiveTokenizer
  alias Wug.Document

  @behaviour Wug.Language

  @punctuation ~w|. ? ! , ; ' " ( )|

  @spec sentencize(Document.t()) :: Document.t()
  def sentencize(doc) do
    DefaultSentencizer.sentencize(doc)
  end

  @spec tokenize(Document.t()) :: Document.t()
  def tokenize(doc) do
    NaiveTokenizer.tokenize(doc, punctuation: @punctuation)
  end
end
