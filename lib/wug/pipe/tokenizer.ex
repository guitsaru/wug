defmodule Wug.Pipe.Tokenizer do
  @moduledoc false

  use Wug.Pipe

  alias Wug.Document

  @spec call(Document.t(), keyword()) :: Document.t()
  def call(%Document{} = doc, language: language) do
    tokens = language.tokenize(doc.text)

    %{doc | tokens: tokens}
  end
end
