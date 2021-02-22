defmodule Wug.Language do
  @moduledoc false

  alias Wug.Token

  @callback tokenize(String.t()) :: [Token.t()]
end
