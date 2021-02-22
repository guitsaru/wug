defmodule Wug.Document do
  @moduledoc false

  alias Wug.Token

  @typep span :: [Token.t()]

  @type t :: %__MODULE__{
          text: String.t(),
          tokens: [Token.t()]
        }

  defstruct text: "", tokens: []

  @spec new(String.t()) :: t()
  def new(text), do: %__MODULE__{text: text}

  @spec sentences(t()) :: [span]
  def sentences(doc) do
    tokens = Enum.sort_by(doc.tokens, & &1.start)

    Enum.chunk_while(
      tokens,
      [],
      fn token, acc ->
        if token.starts_sentence do
          {:cont, Enum.reverse(acc), [token]}
        else
          {:cont, [token | acc]}
        end
      end,
      fn
        [] -> {:cont, []}
        acc -> {:cont, Enum.reverse(acc), []}
      end
    )
  end
end
