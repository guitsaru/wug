defmodule Wug.Document do
  @moduledoc false

  alias Wug.Token

  @type t :: %__MODULE__{
          text: String.t(),
          tokens: [Token.t()]
        }

  defstruct text: "", tokens: []

  @spec new(String.t()) :: t()
  def new(text), do: %__MODULE__{text: text}
end
