defmodule Wug.Tokenizer do
  @moduledoc false

  alias Wug.Document

  @type options :: keyword()

  @callback tokenize(Document.t(), options) :: Document.t()
end
