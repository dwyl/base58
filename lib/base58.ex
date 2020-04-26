defmodule Base58 do
  @moduledoc """
  `Base58` provides two functions: `encode/1` and `decode/1`.
  `encode/1` takes an **Elixir binary** (_String, Number, etc._)
  and returns a Base58 encoded String.
  `decode/1` receives a Base58 encoded String and returns a binary.
  """

  @doc """
  ## Examples

    iex> Base58.encode("hello")
    "Cn8eVZg"

    iex> Base58.encode(42)
    "4yP"
  """
  def encode(""), do: ""
  def encode(binary) when is_binary(binary) do
    # see https://github.com/dwyl/base58/pull/3#discussion_r252291127
    decimal = :binary.decode_unsigned(binary)

    if decimal == 0 do
      # see https://github.com/dwyl/base58/issues/5#issuecomment-459088540
      leading_zeros(binary, "")
    else
      codes = get_codes(decimal, [])
      leading_zeros(binary, "") <> codes_to_string(codes)
    end
  end

  # If the parameter is not a binary convert it to binary before encode.
  def encode(int) when is_integer(int) do
    int
    |> Integer.to_string()
    |> encode()
  end

  def encode(val) when is_float(val) do
    val
    |> Float.to_string()
    |> encode()
  end

  def encode(atom) when is_atom(atom) do
    atom
    |> Atom.to_string()
    |> encode()
  end

  # return a list of codes (codepoint of base58)
  defp get_codes(int, codes) do
    rest = div(int, 58)
    code = rem(int, 58)

    if rest == 0 do
      [code | codes]
    else
      get_codes(rest, [code | codes])
    end
  end

  defp alphanum do
    [ '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F',
    'G', 'H', 'J', 'K', 'L', 'M', 'N', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W',
    'X', 'Y', 'Z', 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'm',
    'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z' ]
  end

  # match codepoints to the alphabet of base58
  defp codes_to_string(codes) do
    codes
    |> Enum.map(&Enum.at(alphanum(), &1))
    |> Enum.join()
  end

  # convert leading zeros to "1"
  defp leading_zeros(<<0, rest::binary>>, acc) do
    leading_zeros(rest, acc <> "1")
  end

  defp leading_zeros(_bin, acc) do
    acc
  end

  @doc """
  `decode/1` decodes the given Base58 string back to binary.
  ## Examples

    iex> Base58.encode("hello") |> Base58.decode()
    "hello"
  """
  @alnum ~c(123456789ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz)

  def decode(""), do: "" # return empty string unmodified
  def decode("\0"), do: "" # treat null values as empty
  def decode(encoded), do: recurse(encoded |> to_char_list, 0)
  defp recurse([], acc), do: acc |> :binary.encode_unsigned()
  defp recurse([head | tail], acc) do
    recurse(tail, (acc * 58) + Enum.find_index(@alnum, &(&1 == head)))
  end

  @doc """
  `decode_to_int/1` decodes the given Base58 string back to an Integer.
  ## Examples

    iex> Base58.encode(42) |> Base58.decode_to_int()
    42
  """
  def decode_to_int(encoded) do
    decode(encoded)
    |> String.to_integer()
  end
end
