defmodule Wug.DefaultSentencizer do
  alias Wug.Document
  alias Wug.Token

  @punctuation_file Path.join(:code.priv_dir(:wug), "punctuation.txt")
  @external_resource @punctuation_file
  @punctuation @punctuation_file |> File.read!() |> String.split()

  @spec sentencize(Document.t()) :: Document.t()
  def sentencize(doc) do
    tokens =
      doc
      |> Document.tokens()
      |> do_sentencize([], true)

    %{doc | tokens: tokens}
  end

  @spec do_sentencize(remaining :: [Token.t()], parsed :: [Token.t()], boolean) :: [Token.t()]
  defp do_sentencize([], parsed, _starts_sentence), do: Enum.reverse(parsed)

  defp do_sentencize([h | t], parsed, starts_sentence) do
    if is_punctuation?(h.text) do
      do_sentencize(t, [h | parsed], true)
    else
      current = %{h | starts_sentence: starts_sentence}
      do_sentencize(t, [current | parsed], false)
    end
  end

  @spec is_punctuation?(String.t()) :: boolean
  defp is_punctuation?(character), do: Enum.member?(@punctuation, character)
end
