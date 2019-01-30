defmodule Example do

  hello = "hello"
  helloBase58 = Base58Encode.encode(hello)

  IO.puts("the \"#{hello}\" binary is represented as \"#{helloBase58}\" in base58")

end
