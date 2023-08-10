defmodule Wug.Token do
  @moduledoc "Represents a single parsed token"

  @type t :: %__MODULE__{
          start: non_neg_integer(),
          starts_sentence: boolean,
          text: String.t(),
          end: non_neg_integer(),
          type: :unk | :punct | :word | :space
        }

  defstruct start: 0, starts_sentence: false, text: "", end: 0, type: :unk

  def new(index) do
    %__MODULE__{start: index}
  end
end
