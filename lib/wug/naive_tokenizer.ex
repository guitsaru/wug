defmodule Wug.NaiveTokenizer do
  alias Wug.Token
  alias Wug.Tokenizer

  @behaviour Wug.Tokenizer

  @typep maybe_token :: Token.t() | nil
  @typep options :: Tokenizer.options()

  @spec tokenize(String.t(), options()) :: [Token.t()]
  def tokenize(text, options) do
    graphemes = String.graphemes(text)

    do_tokenize(graphemes, [], 0, nil, options)
  end

  @spec do_tokenize(
          [String.t()],
          [Token.t()],
          non_neg_integer(),
          maybe_token,
          options
        ) :: [
          Token.t()
        ]
  defp do_tokenize([], tokens, _index, current, _opts), do: push_token(tokens, current)

  defp do_tokenize([h | t], tokens, index, current, options) do
    case parse_character(h, options) do
      {:space, _} ->
        tokens = push_token(tokens, current)
        do_tokenize(t, tokens, index + 1, nil, options)

      {:punctuation, character} ->
        tokens = push_token(tokens, current)
        current = %Token{start: index, text: character}
        do_tokenize(t, tokens, index + 1, current, options)

      {:character, punctuation} ->
        current = current || %Token{start: index}
        current = %{current | text: current.text <> punctuation}
        do_tokenize(t, tokens, index + 1, current, options)
    end
  end

  @spec is_space?(String.t()) :: boolean
  defp is_space?(string), do: String.match?(string, ~r/\s/)

  @spec is_punctuation?(String.t(), options()) :: boolean
  def is_punctuation?(character, options) do
    Enum.member?(Keyword.get(options, :punctuation, []), character)
  end

  @spec push_token([Token.t()], maybe_token) :: [Token.t()]
  defp push_token(acc, nil), do: acc
  defp push_token(acc, token), do: [token | acc]

  @spec parse_character(String.t(), options) ::
          {:space, String.t()}
          | {:punctuation, String.t()}
          | {:character, String.t()}
  defp parse_character(character, options) do
    cond do
      is_space?(character) -> {:space, character}
      is_punctuation?(character, options) -> {:punctuation, character}
      true -> {:character, character}
    end
  end
end
