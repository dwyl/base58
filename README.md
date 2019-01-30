# elixir-base58-encode
[![Hex pm](http://img.shields.io/hexpm/v/b58.svg?style=flat)](https://hex.pm/packages/b58)
[![Build Status](https://travis-ci.org/dwyl/base58encode.svg?branch=master)](https://travis-ci.org/dwyl/base58encode)
[![Coverage Status](https://coveralls.io/repos/dwyl/base58Encode/badge.svg?branch=master)](https://coveralls.io/r/dwyl/base58Encode?branch=master)

This module provides the `Base58Encode.encode/1` function which takes an **Elixir binary** and returns its base58 String representation.

See the section [What is an Elixir binary?](#What-is-an-elixir-binary) for more information about the binary type in Elixir.

## How to use the module

1. Add the package to you dependencies

  ```
  defp deps do
    [b58: "~> 0.1.0"]
  end
  ```

  and run `mix deps.get`

2. Call the `encode` function with a binary as parameter:

 ```
 Base58Encode.encode("foo")
 "bQbp"
 ```

 if the parameter is not an Elixir binary the function will return `:error`. In
 this example 42 is an Integer and not a binary (`is_binary(42)` will return `false`)

 ```
 Base58Encode.encode(42)
 :error
 ```

 See `example/Example.exs` file for a simple example on how to use the module.
 You can also run this example with `mix run example/Example.exs`

## What is base58?

`base58` provides a way to represent an **integer to a string** where the characters of the string are selected from the following list:  

`123456789ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz`

The idea is to map each character of the set to a value: 0 to 1, 2 to 2 ... 57 to z.

The integer is then converted to the base58 list of codes. For example 65
is represented as a list of two codes 1 and 7:
```
65 % 58 = 7 (65 modulo 58 is 7 (65 - 58 * 1 = 7))
1 % 58 = 1

So 65 is represented by 1 7 codes
```

Then by matching these two codes to the base58 character set we have **28**

For more information about the implementation of this module see the issue 1:
[How to encode a string to base58](https://github.com/dwyl/base58encode/issues/1)

Wikipedia page for base58:
https://en.wikipedia.org/wiki/Base56


## What is an Elixiry binary?

From https://elixir-lang.org/getting-started/binaries-strings-and-char-lists.html
> A `binary` is a sequence of bytes

A byte is a sequence of eight bits (i.e a sequence of eight 0 or 1)
For example the following are bytes with their decimal representation:

| byte in base2 | decimal|
| -- | -- |
| 00000001 | 1 |
| 00000010 | 2 |
| 00000011 | 3 |
| 00000100 | 4 |

In Elixir binary is represented and created with `<< >>`

For example the sequence of bytes `00000001 00000010 00000011 00000100`
is `<<1, 2, 3, 4>>` in Elixir.

All Elixir Strings are a binaries but not all binaries are String.
a String is a binary where the numbers represent each letter in UTF8/unicode.
One trick to see the binary representation of a string is to add `<<0>>` at the end of the string with the concatenation operator `<>`:

```
"hello" <> <<0>>
<<104, 101, 108, 108, 111, 0>>

"hello" == <<104, 101, 108, 108, 111 >>
true
```

**A binary in Elixir is different to a [binary number](https://en.wikipedia.org/wiki/Binary_number) which is the representation of a number in base2, e.g 110 represents 6**

However 6 in Elixir is not a binary but an Integer.
You can use the `Integer.to_string` function to see the representation of an integer in different base:

```
Integer.to_string(6, 2)
"110"
```
