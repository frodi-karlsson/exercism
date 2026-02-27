defmodule Darts do
  @type position :: {number, number}

  defguardp is_hypot_lte(x, y, res) when x * x + y * y <= res * res

  @doc """
  Calculate the score of a single dart hitting a target
  """
  @spec score(position) :: integer
  def score(position)
  def score({x, y}) when is_hypot_lte(x, y, 1), do: 10
  def score({x, y}) when is_hypot_lte(x, y, 5), do: 5
  def score({x, y}) when is_hypot_lte(x, y, 10), do: 1
  def score(_), do: 0
end
