defmodule BirdCount do
  def today([head | tail]), do: head
  def today([]), do: nil
  def increment_day_count([head | tail]), do: [head + 1 | tail]
  def increment_day_count([]), do: [1]
  def has_day_without_birds?([head | tail]) do
    if head == 0, do: true, else: has_day_without_birds?(tail)
  end
  def has_day_without_birds?([]), do: false
  def total(list), do: Enum.sum(list)
  def busy_days(list), do: list |> Enum.filter(&(&1 >= 5)) |> Enum.count()
end
