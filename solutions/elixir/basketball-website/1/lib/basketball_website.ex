defmodule BasketballWebsite do
  def extract_from_path(data, path) do
    path
    |> String.split(".")
    |> Enum.reduce(data, fn curr, acc -> acc[curr] end)
  end

  def get_in_path(data, path), do: get_in(data, path |> String.split("."))
end
