defmodule Wug.Pipes.Sentencizer do
  use Wug.Pipe

  alias Wug.Pipeline

  @spec call(Pipeline.t(), keyword()) :: Document.t()
  def call(%Pipeline{} = pipeline, language: language) do
    doc = language.sentencize(pipeline.doc)

    %{pipeline | doc: doc}
  end
end
