defmodule Wug.Pipe.Tokenizer do
  @moduledoc false

  use Wug.Pipe

  alias Wug.Document

  @spec call(Document.t(), keyword()) :: Document.t()
  def call(%Document{} = doc, language: language) do
    language.tokenize(doc)
  end
end
