defmodule Transmission do
  @doc """
  Return the transmission sequence for a message.
  """
  @spec get_transmit_sequence(binary()) :: binary()
  def get_transmit_sequence(message) do
    do_get_transmit_sequence(message, <<>>)

  end

  defp do_get_transmit_sequence(<<>>, acc), do: acc
  defp do_get_transmit_sequence(<<seven::size(7), rest::bitstring>>, acc) do
    is_even = seven |> Integer.to_charlist(2) |> Enum.count(&(&1 == ?1)) |> rem(2) == 0
    do_get_transmit_sequence(rest, acc <> <<seven::size(7), (if is_even, do: 0, else: 1)::size(1)>>)
  end
  defp do_get_transmit_sequence(short_string, acc) do
    do_get_transmit_sequence(
      <<
        short_string::bitstring,
        0::size(7 - bit_size(short_string))
      >>,
      acc
    )
  end

  @doc """
  Return the message decoded from the received transmission.
  """
  @spec decode_message(binary()) :: {:ok, binary()} | {:error, String.t()}
  def decode_message(received_data) do
  received_data
  |> do_decode_message(<<>>)
  end

  defp do_decode_message(<<>>, acc) do
    bytes = div(bit_size(acc), 8)
    <<res::binary-size(bytes), _rest::bitstring>> = acc
    {:ok, res}
  end
  defp do_decode_message(<<seven::7, parity::1, rest::bitstring>>, acc) do
    is_even = seven |> Integer.to_charlist(2) |> Enum.count(&(&1 == ?1)) |> rem(2) == 0
    cond do
      (is_even and parity == 1) or (not is_even and parity == 0) -> {:error, "wrong parity"}
      true -> do_decode_message(rest, <<acc::bitstring, seven::7>>)
    end
  end
end
