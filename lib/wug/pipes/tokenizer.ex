defmodule Wug.Pipes.Tokenizer do
  @moduledoc false

  use Wug.Pipe

  alias Wug.Pipeline

  @spec call(Pipeline.t(), keyword()) :: Document.t()
  def call(%Pipeline{} = pipeline, opts) do
    language = Keyword.fetch!(opts, :language)
    opts = Keyword.delete(opts, :language)

    doc = language.tokenize(pipeline.doc, opts)

    %{pipeline | doc: doc}
  end
end
