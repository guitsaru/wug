defmodule Wug.Language do
  @moduledoc false

  alias Wug.Document

  @callback sentencize(Document.t()) :: Document.t()
  @callback tokenize(Document.t()) :: Document.t()
end
