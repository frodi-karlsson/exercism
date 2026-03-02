defmodule LibraryFees do
  def datetime_from_string(string) do
      [date, time] = String.split(string, ~r/T/)
      [y, mo, d] = String.split(date, ~r/-/) |> Enum.map(&String.to_integer/1)
      [h, mi, s] = String.split(String.slice(time, 0..-2//1), ":") |> Enum.map(&String.to_integer/1)
      {:ok, datetime} = NaiveDateTime.new(y, mo, d, h, mi, s)
      datetime
  end
  def before_noon?(datetime), do: datetime.hour < 12
  def return_date(checkout_datetime) do
    days_to_add = if before_noon?(checkout_datetime), do: 28, else: 29
    NaiveDateTime.add(checkout_datetime, days_to_add, :day) |> NaiveDateTime.to_date()
  end
  def days_late(planned_return_date, actual_return_datetime) do
    diff = Date.diff(actual_return_datetime, planned_return_date)
    if diff > 0, do: diff, else: 0
  end
  def monday?(datetime), do: datetime |> NaiveDateTime.to_date() |> Date.day_of_week() == 1
  def calculate_late_fee(checkout, return, rate) do
    return = datetime_from_string(return)
    factor = if monday?(return), do: 0.5, else: 1
    late = checkout |> datetime_from_string |> return_date() |> days_late(return)
    late * rate * factor |> trunc()
  end
end
