defmodule KitchenCalculator do
  def get_volume({_, v}), do: v
  def to_milliliter({:milliliter, _} = volume_pair), do: volume_pair
  def to_milliliter({:cup, v}), do: {:milliliter, v * 240}
  def to_milliliter({:fluid_ounce, v}), do: {:milliliter, v * 30}
  def to_milliliter({:teaspoon, v}), do: {:milliliter, v * 5}
  def to_milliliter({:tablespoon, v}), do: {:milliliter, v * 15}
  def from_milliliter({:milliliter, v}, unit) do
    ratio = v / (
      {unit, 1}
      |> to_milliliter()
      |> get_volume()
    )
    {unit, ratio}
  end
  def convert(volume_pair, unit), do: volume_pair |> to_milliliter() |> from_milliliter(unit)
end
