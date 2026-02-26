defmodule FreelancerRates do
  def daily_rate(hourly_rate), do: hourly_rate * 8.0
  def apply_discount(before_discount, discount), do: before_discount * (100 - discount) / 100
  def monthly_rate(hourly_rate, discount), do: daily_rate(hourly_rate) * 22 |> apply_discount(discount) |> ceil()
  def days_in_budget(budget, hourly_rate, discount) do
    hourly_rate
    |> daily_rate()
    |> apply_discount(discount)
    |> then(&(budget / &1))
    |> Float.floor(1)
  end
end
