defmodule Wug.Pipes.SentencizerTest do
  use ExUnit.Case, async: true

  alias Wug.Document
  alias Wug.Pipeline
  alias Wug.Pipes.Sentencizer
  alias Wug.Pipes.Tokenizer

  describe "call/1" do
    test "sentencizes nothing" do
      pipeline =
        ""
        |> make_pipeline()
        |> Tokenizer.call(language: TestLanguage)
        |> Sentencizer.call(language: TestLanguage)

      assert pipeline.doc |> Document.sentences() |> Enum.count() == 0
    end

    test "tokenizes a sentence" do
      pipeline =
        "This is a test. This is still a test. No, really, this is a test"
        |> make_pipeline()
        |> Tokenizer.call(language: TestLanguage)
        |> Sentencizer.call(language: TestLanguage)

      assert pipeline.doc |> Document.sentences() |> Enum.count() == 3
    end
  end

  defp make_pipeline(text) do
    %Pipeline{doc: Document.new(text)}
  end
end
