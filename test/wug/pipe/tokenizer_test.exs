defmodule Wug.Pipe.TokenizerTest do
  use ExUnit.Case, async: true

  alias Wug.Document
  alias Wug.Languages.English
  alias Wug.Pipe.Tokenizer

  describe "call/1" do
    test "tokenizes nothing" do
      doc =
        ""
        |> Document.new()
        |> Tokenizer.call(language: English)

      assert Enum.count(doc.tokens) == 0
    end

    test "tokenizes a sentence" do
      doc =
        "This is a test."
        |> Document.new()
        |> Tokenizer.call(language: English)

      assert Enum.count(doc.tokens) == 5
    end
  end
end
