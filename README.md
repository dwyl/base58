<div align="center">

# `b58` - _Minimalist_ Elixir Base58 Encoding/Decoding Library

[![Build Status](https://img.shields.io/travis/dwyl/base58/master.svg?style=flat-square)](https://travis-ci.org/dwyl/base58)
[![codecov.io](https://img.shields.io/codecov/c/github/dwyl/base58/master.svg?style=flat-square)](http://codecov.io/github/dwyl/base58?branch=master)
[![Hex.pm](https://img.shields.io/hexpm/v/base58?color=brightgreen&style=flat-square)](https://hex.pm/packages/base58)
[![Libraries.io dependency status](https://img.shields.io/librariesio/release/hex/base58?logoColor=brightgreen&style=flat-square)](https://libraries.io/hex/base58)
[![contributions welcome](https://img.shields.io/badge/contributions-welcome-brightgreen.svg?style=flat-square)](https://github.com/dwyl/base58/issues)
[![HitCount](http://hits.dwyl.io/dwyl/base58.svg)](http://hits.dwyl.io/dwyl/base58)
<!-- uncomment when service is working ...
[![Inline docs](http://inch-ci.org/github/dwyl/base58.svg?branch=master&style=flat-square)](http://inch-ci.org/github/dwyl/base58)
-->

![base58-encode-hero-image](https://user-images.githubusercontent.com/194400/80292242-1d2de500-874d-11ea-8514-91a8fdfabfde.jpg)


</div>

`Base58` provides two functions to
work with Base58 encoded strings: `Base58.encode/1` and `Base58.decode/1`  <br />
`encode/1` takes an **Elixir binary** (_String, Number, etc._)
and returns a Base58 encoded String. <br />
`decode/1` receives a Base58 encoded String and returns a binary.

See the section [What is an Elixir binary?](#what-is-an-elixir-binary) for more information about the binary type in Elixir.

## How to use the module?

### 1. Add the package to you dependencies

Open your `mix.exs` file and add the following line to your `deps`:

```elixir
defp deps do
  [
    {:b58, "~> 1.0"},
  ]
end
```

and run `mix deps.get`

### 2. Invoke the `encode/1` function with a binary as parameter:

```elixir
Base58.encode("foo")
"bQbp"
```

### 3. Invoke the `decode/1` function with a `base58` encoded string:

```elixir
Base58.encode("hello") |> Base58.decode()
"hello"
```

<br />


See `example/example.exs` file
for a simple example of how to use the module. <br />
You can also run this example with `mix run example/example.exs`


### Note: `Integer` Values are Converted to `String`

When encoding an `Integer`
the value is converted to a `String` before encoding
so when it is decoded it will be a string e.g:

```elixir
Base58.encode(42) |> Base58.decode()
"42"
```

This isn't ideal if you _expected_ an `Integer`
but there is no way to encode the **`type`** of the data.
So if you _know_ that you need it to be an `int`,
convert it back to a numeric value with `Base58.decode_to_int/1`:

```elixir
iex(1)> Base58.encode(42) |> Base58.decode_to_int()
42
```



<br /> <br />

## Why?




## What is Base58?

A *base* is a set of characters used for representing numbers.
https://en.wikipedia.org/wiki/Base58

For example
- The base 2 (binary system) represents numbers with the digits ` 0 1`
- The base 10 (decimal system) represents numbers with the digits `0 1 2 3 4 5 6 7 8 9`.
- The base 16 (hexadecimal system) represents numbers with the digits `0 1 2 3 4 5 6 7 8 9 A B C D E F`


The `2, 10, 16` are called **radix** and represent the number of unique digits in the base.

Bases are **positional numeral systems**. This means that the place of a digit matters,
for example we can define the place for each digit of the number 423 as:

| digit | place|
| --    | -- |
| 3  | 0  |
| 2  | 1  |
| 4  | 2  |


### From a base b to decimal

To calculate the value of a number in a specific base to base 10, we are using
the place of the digit, the radix and the function exponential as following:

**423** in base b is **4 x b<sup>2</sup> + 2 x b<sup>1</sup> + 3 x b<sup>0</sup>**

So **423** in base 10 is **4 x 10<sup>2</sup> + 2 x 10<sup>1</sup> + 3 x 10<sup>0</sup>**

another example on base 16 with the number **F66**:
We know that F is 15 in base 10, then by using exponentials and places we have
**F66** is **15 x 16<sup>2</sup> + 6 x 16<sup>1</sup> + 6 * 16<sup>0</sup>** which is
**3942**

### From decimal to base b

To convert a decimal d to base b
1. Get the remainder of d by b: `rem(d, b)` and note down the result.
2. Get the integer division of d by b:`d1 = div(d, b)` and repeat the step 1 with `rem(d1, b)`
3. Stop this process when the division returns 0
4. Match each number of the sequence of remainder to the base

For example 12 in base 2 is:

```
r0 = 0 = rem(12, 2)
d0 = 6 = div(12, 2)


r1 = 0 = rem(d0, 2) = rem(6,2)
d1 = 3 = div(6, 2)


r2 = 1 = rem(d1, 2) = rem(3, 2)
d2 = 1 = div(3, 2)

r3 = 1 = rem(d2, 2) = rem(1, 2)
d3 = 0 = div(1, 2) # stop the process

# 12 in base 2 is r3 r2 r1 r0 which is 1100
```

### Decimal to base58

`base58` represents number with the follwing character set:

`123456789ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz`

where
` 0 -> "1", 1 -> "2", ..., 57 -> "z"`

If we take the process on the previous section with **65** and apply it with base58 we have:

```
r0 = 7 = rem(65, 58)
d0 = 1 = div(65, 58)

r1 = 1 = rem(1, 58)
d1 = 0 = div(1, 58) # stop the process

# r1 r0 is 1 7 and with the base58 characters 1 is 2 and 7 is 8
# So 65 in base 10 is 28 in base 58
```

Note that if a binary start with [leading zeros](https://en.wikipedia.org/wiki/Leading_zero) then
the zeros are represented as "1" in base58.
So <<0, 0, 0, 1>> is defined as "1112" in base58.

from https://en.bitcoin.it/wiki/Base58Check_encoding

> The leading character '1', which has a value of zero in base58, is reserved for representing an entire leading zero byte

For more information about the implementation of this module see the issue 1:
[How to encode a string to base58](https://github.com/dwyl/base58encode/issues/1)

Wikipedia page for Base:
https://en.wikipedia.org/wiki/Radix

## Why Base58?

The base 58 character set is a subset of the base 64 where non-alphanumeric characters
have been removed and also `0OIl` letters to keep the string easily readable.

base 58 uses comes from Bitcoin and blockchain. It is also used with [IPFS](https://ipfs.io/)
to create [Content Identifier](https://github.com/dwyl/cid/)

Wikipedia page for base58:
https://en.wikipedia.org/wiki/Base56

## What is an Elixir binary?

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

All Elixir Strings are a binaries but not all binaries are Strings.
A String is a binary where the numbers represent each letter in UTF8/unicode.
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
Integer.to_string(6, 2) # 6 as binary number in base 2
"110"

Integer.to_string(10, 2) # 10 as binary number in base 2
"1010"

Integer.to_string(10, 10) # 10 as a decimal number in base 10
"10"

Integer.to_string(10, 16) # 10 as an hexadecimal number in base 16
"A"

Integer.to_string(15, 16) # 15 as an hexadecimal number in base 16
"F"
```
