# elixir-base58-encode
https://hex.pm/packages/b58


This module provide the `encode/1` function which takes a binary and returns
its base58 representation

1. Add the package to you dependencies

  ```
  defp deps do
    [b58: "~> 0.1.0"]
  end
  ```

  and run `mix deps.get`

2. Call the `encode` fundtion with a binary as parameter:

 ```
 > Base58Encode.encode("foo")
 > "bQbp"
 ```

 if the parameter is not a binary the function will return `:error`

 ```
 > Base58Encode.encode(42)
 > "bQbp"
 ```

The alphabet used for base58 is:
`123456789ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz`

For more information about the implementation of this module see the issue 1:
[How to encode a string to base58](https://github.com/dwyl/base58encode/issues/1)

Read the following for more information about binary in Elixir:
https://elixir-lang.org/getting-started/binaries-strings-and-char-lists.html

Wikipedia page for base58:
https://en.wikipedia.org/wiki/Base56
