defmodule Username do
  def sanitize(username) do
    username
    |> Enum.flat_map(fn symbol ->
      case symbol do
        ?ä -> ~c"ae"
        ?ö -> ~c"oe"
        ?ü -> ~c"ue"
        ?ß -> ~c"ss"
        s when ?a <= s and s <= ?z -> [s]
        s when ?_ == s -> [s]
        _ -> ~c""
      end
    end)
  end
end
