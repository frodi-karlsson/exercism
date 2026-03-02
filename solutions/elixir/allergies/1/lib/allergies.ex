defmodule Allergies do
  @dec_to_allergy %{
    1 => "eggs",
    2 => "peanuts",
    4 => "shellfish",
    8 => "strawberries",
    16 => "tomatoes",
    32 => "chocolate",
    64 => "pollen",
    128 => "cats"
  }
  @allergy_to_dec Map.new(@dec_to_allergy, fn {k, v} -> {v, k} end)
  @doc """
  List the allergies for which the corresponding flag bit is true.
  """
  @spec list(non_neg_integer) :: [String.t()]
  def list(flags) do
    @dec_to_allergy
    |> Enum.filter(fn {k, _} -> Bitwise.band(flags, k) != 0 end)
    |> Enum.map(fn {_, v} -> v end)
  end

  @doc """
  Returns whether the corresponding flag bit in 'flags' is set for the item.
  """
  @spec allergic_to?(non_neg_integer, String.t()) :: boolean
  def allergic_to?(flags, item) do
    case @allergy_to_dec[item] do
      nil -> false
      dec when Bitwise.band(dec, flags) != 0 -> true
      _ -> false
    end
  end
end
