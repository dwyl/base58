defmodule Base58Test do
  use ExUnit.Case
  use ExUnitProperties

  doctest Base58
  import Base58

  describe "Testing encode function" do
    test "returns base58 for the string foo" do
      assert "bQbp" == encode("foo")
    end

    test "returns error if parameter is not a binary" do
      assert :error == encode(23)
    end

    test "returns z when binary is represented by 57" do
      assert "z" == encode(<<57>>)
    end

    test "returns empty string when encoding an empty string" do
      assert "" == encode("")
    end

    test "add leading zeros as \"1\"" do
      assert "1112" == encode(<<0, 0, 0, 1>>)
    end

    test "encode empty string" do
      assert "Z" == encode(" ")
    end

    test "encode <<0>> retuens 1" do
      assert "1" == encode(<<0>>)
    end

    test "encode <<0, 0, 0, 0, 0>> returns 11111" do
      assert "11111" == encode(<<0, 0, 0, 0, 0>>)
    end

    property "Compare result with basefiftyeight package" do
      check all bin <- binary() do
        assert B58.encode58(bin) == encode(bin)
      end
    end

    
  end
end
