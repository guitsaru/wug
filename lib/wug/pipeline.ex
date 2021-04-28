defmodule Wug.Pipeline do
  @moduledoc false

  alias __MODULE__
  alias Wug.Document
  alias Wug.Language
  alias Wug.Pipe

  @type t :: %__MODULE__{
          doc: Document.t(),
          language: Language.t(),
          pipes: [Pipe.t()]
        }

  defstruct language: nil, doc: Document.new(""), pipes: []

  defmacro __using__(opts) do
    quote location: :keep do
      alias unquote(Pipeline)
      import Pipeline, only: [pipe: 1, pipe: 2]

      Module.register_attribute(__MODULE__, :pipes, accumulate: true)
      @options unquote(List.wrap(opts))

      @spec call(Document.t() | String.t(), Keyword.t()) :: Document.t()
      def call(document_or_string, opts \\ [])

      def call(%Document{} = document, opts) do
        options =
          @options
          |> Keyword.merge(opts)
          |> Keyword.put(:pipes, default_pipes())
          |> Keyword.put(:doc, document)

        pipeline = struct(Pipeline, options)

        process(pipeline).doc
      end

      def call(string, opts) when is_binary(string) do
        document = Document.new(string)

        call(document, opts)
      end

      @spec process(Pipeline.t()) :: Pipeline.t()
      defp process(%Pipeline{pipes: []} = pipeline), do: pipeline

      defp process(%Pipeline{pipes: [{pipe, opts} | rest]} = pipeline) do
        opts = Keyword.put_new(opts, :language, pipeline.language)

        %{pipeline | pipes: rest}
        |> pipe.call(opts)
        |> process()
      end

      @before_compile Pipeline
    end
  end

  defmacro __before_compile__(env) do
    pipes = Module.get_attribute(env.module, :pipes, [])

    quote do
      defp default_pipes, do: unquote(pipes)
    end
  end

  defmacro pipe(pipe, opts \\ []) do
    quote location: :keep do
      @pipes {unquote(pipe), unquote(opts)}
    end
  end
end
