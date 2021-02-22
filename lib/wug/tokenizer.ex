defmodule Wug.Tokenizer do
  @moduledoc false

  alias Wug.Token

  @type options :: keyword()

  @callback tokenize(String.t(), options) :: [Token.t()]
end
