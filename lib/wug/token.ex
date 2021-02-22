defmodule Wug.Token do
  @type t :: %__MODULE__{
          start: non_neg_integer(),
          text: String.t()
        }

  defstruct start: 0, text: ""
end
