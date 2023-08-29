defmodule Wug.Pipes.TokenizerTest do
  use ExUnit.Case, async: true

  alias Wug.Document
  alias Wug.Pipeline
  alias Wug.Pipes.Tokenizer

  describe "call/1" do
    test "tokenizes nothing" do
      pipeline =
        ""
        |> make_pipeline()
        |> Tokenizer.call(language: TestLanguage)

      assert Enum.count(pipeline.doc.tokens) == 0
    end

    test "tokenizes a sentence" do
      pipeline =
        "This is a test."
        |> make_pipeline()
        |> Tokenizer.call(language: TestLanguage)

      assert Enum.count(pipeline.doc.tokens) == 5
    end
  end

  defp make_pipeline(text) do
    %Pipeline{doc: Document.new(text)}
  end
end
