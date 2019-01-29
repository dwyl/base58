defmodule Base58Encode do

 def encode(binary) do
  {decimal, _} = Integer.parse(Base.encode16(binary), 16)
  codes = get_codes(decimal, [])
  codes_to_string(codes)
 end

 defp get_codes(int, codes) do
   rest = div(int, 58)
   code = rem(int, 58)
   if  rest == 0 do
     [code | codes]
   else
     get_codes(rest, [code | codes])
  end
 end

 defp codes_to_string(codes) do
  alphabet =  [ '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A',
                'B', 'C', 'D', 'E', 'F', 'G', 'H', 'J', 'K', 'L',
                'M', 'N', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W',
                'X', 'Y', 'Z', 'a', 'b', 'c', 'd', 'e', 'f', 'g',
                'h', 'i', 'j', 'k', 'm', 'n', 'o', 'p', 'q', 'r',
                's', 't', 'u', 'v', 'w', 'x', 'y', 'z' ]

  codes
  |> Enum.map(fn c -> Enum.at(alphabet, c) end)
  |> Enum.join()
 end

end
