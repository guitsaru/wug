defmodule Wug.Pipes.PipelineTest do
  use ExUnit.Case, async: true

  alias Wug.Document
  alias Wug.Languages.English
  alias Wug.Pipes.Sentencizer
  alias Wug.Pipes.Tokenizer

  defmodule EmptyPipeline do
    use Wug.Pipeline
  end

  defmodule TokenizerPipeline do
    use Wug.Pipeline, language: English

    pipe Tokenizer
  end

  defmodule SentencizerPipeline do
    use Wug.Pipeline, language: English

    pipe Tokenizer
    pipe Sentencizer
  end

  describe "call/1" do
    test "runs an empty pipeline" do
      result = EmptyPipeline.call("")

      assert result.text == ""
    end

    test "runs the tokenizer pipe" do
      result = TokenizerPipeline.call("This is a test.")

      assert Enum.count(result.tokens) == 5
    end

    test "runs the sentencizer pipe" do
      result = SentencizerPipeline.call("This is a test.")

      assert result |> Document.sentences() |> Enum.count() == 1
    end
  end
end
