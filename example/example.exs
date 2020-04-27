defmodule Example do

  hello = "hello"
  helloBase58 = Base58.encode(hello)
  helloBase58Decode = Base58.decode(helloBase58)

  IO.puts("the \"#{hello}\" binary is represented as \"#{helloBase58}\" in base58")
  IO.puts("the \"#{helloBase58Decode}\" decoded is #{hello})")

end
