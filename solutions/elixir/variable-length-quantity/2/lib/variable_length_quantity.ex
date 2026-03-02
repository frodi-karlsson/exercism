defmodule VariableLengthQuantity do
  import Bitwise
  @doc """
  Encode integers into a bitstring of VLQ encoded bytes
  """
  @spec encode(integers :: [integer]) :: binary
  def encode(integers) do for int <- integers, into: <<>>, do: pack_in_seven(<<int::32>>)
  end


  defp pack_in_seven(bit_string) do
    size = bit_string |> bit_size()
    pad = rem(size, 7)
    padded = if pad == 0, do: bit_string, else: <<0::size(7 - pad), bit_string::bitstring>>
    chunks =
      for(<<chunk::7 <- padded>>, do: chunk)
      |> Enum.drop_while(&(&1 == 0))
      |> then(fn [] -> [0]; trimmed -> trimmed end)

    [last | rest] = Enum.reverse(chunks)
    ([<<0::1, last::7>> | Enum.map(rest, &<<1::1, &1::7>>)])
      |> Enum.reverse()
      |> Enum.into(<<>>)
  end

  @doc """
  Decode a bitstring of VLQ encoded bytes into a series of integers
  """
  @spec decode(bytes :: binary) :: {:ok, [integer]} | {:error, String.t()}
  def decode(bytes) do
    for <<bit::1, chunk::7 <- bytes>>, reduce: {[], 0, false} do
      {acc, current, _} when bit == 0 -> {[(current <<< 7 ||| chunk) | acc], 0, false}
      {acc, current, _} when bit == 1 -> {acc, current <<< 7 ||| chunk, true}
    end
    |> then(fn
      {acc, 0, false} -> {:ok, Enum.reverse(acc)}
      _ -> {:error, "incomplete sequence"}
    end)
  end
end
