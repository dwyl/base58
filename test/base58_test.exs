defmodule ExBase58Test do
  use ExUnit.Case
  use ExUnitProperties

  doctest ExBase58
  import ExBase58

  describe "Testing encode function" do
    test "returns empty string when encoding an empty string" do
      assert "" == encode("")
    end

    test "returns base58 for the string foo" do
      assert "bQbp" == encode("foo")
    end

    test "converts any value to binary and then Base58 encodes it" do
      assert "m8UW" == encode(23) # Integer
      assert "8NmHr9odQSJL4n" == encode(3.14)
      assert "2g14LRptojh8i" == encode(:hello) # Atom
    end

    test "returns z when binary is represented by 57" do
      assert "z" == encode(<<57>>)
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
