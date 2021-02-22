defmodule Wug.Languages.English do
  alias Wug.NaiveTokenizer
  alias Wug.Token

  @behaviour Wug.Language

  @punctuation ~w|. ? ! , ; ' " ( )|

  @spec tokenize(String.t()) :: [Token.t()]
  def tokenize(text) do
    NaiveTokenizer.tokenize(text, punctuation: @punctuation)
  end
end
