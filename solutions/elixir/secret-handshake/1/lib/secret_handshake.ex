defmodule SecretHandshake do
  @command_for_dec %{
    1 => "wink",
    2 => "double blink",
    4 => "close your eyes",
    8 => "jump"
  }
  @doc """
  Determine the actions of a secret handshake based on the binary
  representation of the given `code`.

  If the following bits are set, include the corresponding action in your list
  of commands, in order from lowest to highest.

  1 = wink
  10 = double blink
  100 = close your eyes
  1000 = jump

  10000 = Reverse the order of the operations in the secret handshake
  """
  @spec commands(code :: integer) :: list(String.t())
  def commands(code) do
    keys = Map.keys(@command_for_dec)
    handshake = keys
    |> Enum.sort()
    |> Enum.map(&(if Bitwise.band(code, &1) == &1, do: @command_for_dec[&1], else: nil))
    |> Enum.filter(&(not is_nil(&1)))

    next_bit = Bitwise.bsl(Enum.max(keys), 1)
    if (Bitwise.band(next_bit, code) == next_bit) do
      Enum.reverse(handshake)
    else
      handshake
    end

  end
end
