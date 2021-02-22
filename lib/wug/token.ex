defmodule Wug.Token do
  @type t :: %__MODULE__{
          start: non_neg_integer(),
          starts_sentence: boolean,
          text: String.t()
        }

  defstruct start: 0, starts_sentence: false, text: ""
end
