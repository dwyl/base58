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

 def encode(binary) when is_binary(binary) do
   case Integer.parse(Base.encode16(binary), 16) do
      :error -> :error

      {decimal, _} ->
        codes = get_codes(decimal, [])
        codes_to_string(codes)
   end
 end

 # If the parameter is not a binary, return an error
 def encode(_), do: :error


# return a list of codes (codepoint of base58)
 defp get_codes(int, codes) do
   rest = div(int, 58)
   code = rem(int, 58)
   IO.inspect "rest #{rest}"
   IO.inspect code
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

end
