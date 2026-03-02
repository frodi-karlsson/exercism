defmodule Ledger do
  @doc """
  Format the given entries given a currency and locale
  """
  @type currency :: :usd | :eur
  @type locale :: :en_US | :nl_NL
  @type entry :: %{amount_in_cents: integer(), date: Date.t(), description: String.t()}

  @headers %{
    en_US: "Date       | Description               | Change       \n",
    nl_NL: "Datum      | Omschrijving              | Verandering  \n"
  }

  @spec format_entries(currency(), locale(), list(entry())) :: String.t()
  def format_entries(_, locale, []), do: @headers[locale]

  def format_entries(currency, locale, entries) do
    header = @headers[locale]

    entries =
      entries
      |> Enum.sort_by(& &1.amount_in_cents)
      |> Enum.map(&format_entry(currency, locale, &1))
      |> Enum.join("\n")

    header <> entries <> "\n"
  end

  defp format_entry(currency, locale, entry) do
    date = format_date(entry.date, locale)
    amount = format_amount(entry.amount_in_cents, locale, currency)
    description = format_description(entry.description)
    [date, description, amount] |> Enum.join("|")
  end

  defp format_date(%Date{year: year, month: month, day: day}, :en_US),
    do: format_date_parts([month, day, year], "/") <> " "

  defp format_date(%Date{year: year, month: month, day: day}, _),
    do: format_date_parts([day, month, year], "-") <> " "

  defp format_date_parts(parts, sep) do
    parts
    |> Enum.map(fn date_part ->
      date_part
      |> Integer.to_string()
      |> String.pad_leading(2, "0")
    end)
    |> Enum.join(sep)
  end

  defp format_amount(amounts_in_cents, locale, cur) do
    cents = format_cents(amounts_in_cents, locale)

    cur_str =
      case cur do
        :eur -> "€"
        _ -> "$"
      end

    format_line(cents, locale, cur_str, amounts_in_cents < 0) |> String.pad_leading(14, " ")
  end

  defp format_line(cents, locale, cur_str, negative) do
    case {locale, negative} do
      {:en_US, true} -> " (#{cur_str}#{cents})"
      {:en_US, false} -> "  #{cur_str}#{cents} "
      {_, true} -> " #{cur_str} -#{cents} "
      {_, false} -> " #{cur_str} #{cents} "
    end
  end

  defp format_cents(amount_in_cents, :en_US), do: format_cents(amount_in_cents, ",", ".")
  defp format_cents(amount_in_cents, _locale), do: format_cents(amount_in_cents, ".", ",")

  defp format_cents(amount_in_cents, sep_whole, sep_dec) do
    cents_abs = amount_in_cents |> abs()

    whole =
      cents_abs
      |> div(100)
      |> Integer.to_string()
      |> String.graphemes()
      |> Enum.reverse()
      |> Enum.chunk_every(3)
      |> Enum.map(&Enum.join(&1))
      |> Enum.join(sep_whole)
      |> String.reverse()

    decimal = cents_abs |> rem(100) |> to_string() |> String.pad_leading(2, "0")

    Enum.join([whole, decimal], sep_dec)
  end

  defp format_description(description) do
    " " <>
      cond do
        String.length(description) >= 26 -> String.slice(description, 0, 22) <> "..."
        true -> String.pad_trailing(description, 25, " ")
      end <> " "
  end
end
