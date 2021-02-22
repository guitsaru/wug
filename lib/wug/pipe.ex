defmodule Wug.Pipe do
  @moduledoc false

  alias Wug.Document

  @typep options :: keyword()

  @callback call(Document.t(), options) :: Document.t()

  defmacro __using__(_module) do
    quote do
      @behaviour Wug.Pipe
    end
  end
end
