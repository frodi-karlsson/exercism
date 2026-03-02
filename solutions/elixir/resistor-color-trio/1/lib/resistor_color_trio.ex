defmodule ResistorColorTrio do
  @color_to_ohm %{
    black: 0,
    brown: 1,
    red: 2,
    orange: 3,
    yellow: 4,
    green: 5,
    blue: 6,
    violet: 7,
    grey: 8,
    white: 9
  }
  @doc """
  Calculate the resistance value in ohms from resistor colors
  """
  @spec label(colors :: [atom]) :: {number, :ohms | :kiloohms | :megaohms | :gigaohms}
  def label([a, b, c]) do
    base = @color_to_ohm[a] * 10 + @color_to_ohm[b]
    multiplier = (10 - Enum.count([a, b], &(&1 == 0))) ** @color_to_ohm[c]
    total = base * multiplier

    cond do
      total < 1000 -> {total, :ohms}
      total < 1_000_000 -> {div(total, 1000), :kiloohms}
      total < 1_000_000_000 -> {div(total, 1_000_000), :megaohms}
      total < 1_000_000_000_000 -> {div(total, 1_000_000_000), :gigaohms}
    end
  end
  def label(list), do: label(Enum.slice(list, 0..2))
end
