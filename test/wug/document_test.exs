defmodule Wug.DocumentTest do
  use ExUnit.Case, async: true

  alias Wug.Document

  describe "new/1" do
    test "creates a document" do
      text = "This is a document."
      doc = Document.new(text)

      assert doc.text == text
    end
  end
end
