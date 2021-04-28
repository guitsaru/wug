defmodule Wug.Pipe do
  @moduledoc false

  alias Wug.Pipeline

  @type t :: module()
  @typep options :: keyword()

  @callback call(Pipeline.t(), options) :: Pipeline.t()

  defmacro __using__(_opts) do
    quote do
      @behaviour Wug.Pipe
    end
  end
end
