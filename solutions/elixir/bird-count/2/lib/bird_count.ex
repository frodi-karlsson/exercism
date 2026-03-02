defmodule BirdCount do
  def today([head | _tail]), do: head
  def today([]), do: nil
  def increment_day_count([head | tail]), do: [head + 1 | tail]
  def increment_day_count([]), do: [1]
  def has_day_without_birds?([head | tail]) do
    if head == 0, do: true, else: has_day_without_birds?(tail)
  end
  def has_day_without_birds?([]), do: false
  def total(list, sum \\ 0)
  def total([head | tail], sum), do: total(tail, sum + head)
  def total([], sum), do: sum;
  def busy_days(list, count \\ 0)
  def busy_days([head | tail], count) do
    busy_days(tail, count + (if head >= 5, do: 1, else: 0))
  end
  def busy_days([], count), do: count
end
