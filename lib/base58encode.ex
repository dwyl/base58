defmodule Base58Encode do
  @moduledoc """
  Provides the encode function which takes a binary and return it's
  reprentation in base58
  """

  @doc """
  ## Examples

    iex> Base58Encode.encode("hello")
    "Cn8eVZg"

    iex> Base58Encode.encode(42)
    :error
  """

 def encode(""), do: ""

 def encode(<<0>>), do: "1"

 def encode(binary) when is_binary(binary) do
  # see https://github.com/dwyl/base58encode/pull/3#discussion_r252291127
  decimal = :binary.decode_unsigned(binary)
  codes = get_codes(decimal, [])
  leading_zeros(binary, "") <> codes_to_string(codes)
 end


 # If the parameter is not a binary, return an error
 def encode(_), do: :error


# return a list of codes (codepoint of base58)
 defp get_codes(int, codes) do
   rest = div(int, 58)
   code = rem(int, 58)
   if  rest == 0 do
     [code | codes]
   else
     get_codes(rest, [code | codes])
   end
 end

 # match codepoints to the alphabet of base58
 defp codes_to_string(codes) do
  alphabet =  [ '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A',
                'B', 'C', 'D', 'E', 'F', 'G', 'H', 'J', 'K', 'L',
                'M', 'N', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W',
                'X', 'Y', 'Z', 'a', 'b', 'c', 'd', 'e', 'f', 'g',
                'h', 'i', 'j', 'k', 'm', 'n', 'o', 'p', 'q', 'r',
                's', 't', 'u', 'v', 'w', 'x', 'y', 'z' ]

  codes
  |> Enum.map(&(Enum.at(alphabet, &1)))
  |> Enum.join()
 end

 # convert leading zeros to "1"
 defp leading_zeros(<<0, rest::binary>>, acc) do
   leading_zeros(rest, acc <> "1")
 end

 defp leading_zeros(_bin, acc) do
   acc
 end

end
