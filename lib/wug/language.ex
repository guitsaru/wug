defmodule Wug.Language do
  @moduledoc false

  alias Wug.Document

  @type t :: module()

  @callback sentencize(Document.t(), Keyword.t()) :: Document.t()
  @callback tokenize(Document.t(), Keyword.t()) :: Document.t()
end
