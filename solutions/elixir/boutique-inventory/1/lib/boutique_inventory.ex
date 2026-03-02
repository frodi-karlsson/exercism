defmodule BoutiqueInventory do
  def sort_by_price(inventory), do: inventory |> Enum.sort_by(& &1.price)

  def with_missing_price(inventory), do: Enum.filter(inventory, &is_nil(&1.price))

  def update_names(inventory, old_word, new_word) do
    inventory
    |> Enum.map(fn item ->
      item |> Map.update(:name, "", &String.replace(&1, old_word, new_word))
    end)
  end

  def increase_quantity(item, count) do
    item
    |> Map.update(:quantity_by_size, %{}, fn size_map ->
      [:s, :m, :l, :xl]
      |> Enum.filter(&Map.has_key?(size_map, &1))
      |> Map.new(&{&1, Map.get(size_map, &1) + count})
    end)
  end

  def total_quantity(item), do: item |> Map.get(:quantity_by_size) |> Map.values() |> Enum.sum()
end
