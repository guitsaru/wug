defmodule Wug.Pipes.Tokenizer do
  @moduledoc false

  use Wug.Pipe

  alias Wug.Pipeline

  @spec call(Pipeline.t(), keyword()) :: Document.t()
  def call(%Pipeline{} = pipeline, language: language) do
    doc = language.tokenize(pipeline.doc)

    %{pipeline | doc: doc}
  end
end
