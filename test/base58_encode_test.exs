defmodule Base58EncodeTest do
  use ExUnit.Case
  doctest Base58Encode

  describe "Testing encode function" do
    test "returns base58 for the string foo" do
      assert "bQbp" == Base58Encode.encode("foo")
    end

    test "returns error if parameter is not a binary" do
      assert :error == Base58Encode.encode(23)
    end

    test "returns z when binary is represented by 57" do
      assert "z" == Base58Encode.encode(<<57>>)
    end
  end
end
