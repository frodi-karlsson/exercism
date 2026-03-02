defmodule WineCellar do
  @color_explanations [
    white: "Fermented without skin contact.",
    red: "Fermented with skin contact using dark-colored grapes.",
    rose: "Fermented with some skin contact, but not enough to qualify as a red wine."
  ]

  def explain_colors do
    @color_explanations
  end

  def filter(cellar, color, opts \\ []) do
    wines =
      cellar
      |> Enum.filter(fn {wine_color, _} -> color == wine_color end)
      |> Enum.map(fn {_, wine} -> wine end)

    wines =
      case Keyword.get_values(opts, :year) do
        [] -> wines
        years -> Enum.reduce(years, wines, fn curr, acc -> filter_by_year(acc, curr) end)
      end

    case Keyword.get_values(opts, :country) do
      [] -> wines
      countries -> Enum.reduce(countries, wines, fn curr, acc -> filter_by_country(acc, curr) end)
    end
  end

  # The functions below do not need to be modified.

  defp filter_by_year(wines, year)
  defp filter_by_year([], _year), do: []

  defp filter_by_year([{_, year, _} = wine | tail], year) do
    [wine | filter_by_year(tail, year)]
  end

  defp filter_by_year([{_, _, _} | tail], year) do
    filter_by_year(tail, year)
  end

  defp filter_by_country(wines, country)
  defp filter_by_country([], _country), do: []

  defp filter_by_country([{_, _, country} = wine | tail], country) do
    [wine | filter_by_country(tail, country)]
  end

  defp filter_by_country([{_, _, _} | tail], country) do
    filter_by_country(tail, country)
  end
end
