defmodule DNA do
  @acid_to_code_dec %{
    ?\s => 0,
    ?A => 1,
    ?C => 2,
    ?G => 4,
    ?T => 8
  }
  @code_dec_to_acid Map.new(@acid_to_code_dec, fn {key, val} -> {val, key} end)

  def encode_nucleotide(code_point), do: @acid_to_code_dec[code_point]

  def decode_nucleotide(encoded_code), do: @code_dec_to_acid[encoded_code]

  def encode(dna), do: do_encode(dna, <<>>)

  defp do_encode([], bits), do: bits

  defp do_encode([head | tail], bits) do
    do_encode(tail, <<bits::bitstring, encode_nucleotide(head)::4>>)
  end

  def decode(dna), do: do_decode(dna, [])

  defp do_decode(<<>>, bits), do: bits

  defp do_decode(<<head::4, tail::bitstring>>, bits) do
    do_decode(tail, bits ++ [decode_nucleotide(head)])
  end
end
