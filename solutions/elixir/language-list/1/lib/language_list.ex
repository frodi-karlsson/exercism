defmodule LanguageList do
  def new(), do: []
  def add(list, language), do: [language | list]
  def remove([_head | rest]), do: rest
  def first([head | _rest]), do: head
  def count(list), do: length(list)
  def functional_list?(list), do: list |> Enum.member?("Elixir")
end
