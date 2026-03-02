defmodule Username do
  def sanitize(username) do
    username
    |> Enum.flat_map(fn symbol ->
      case symbol do
        symbol when symbol == ?ä -> ~c"ae"
        symbol when symbol == ?ö -> ~c"oe"
        symbol when symbol == ?ü -> ~c"ue"
        symbol when symbol == ?ß -> ~c"ss"
        symbol when ?a <= symbol and symbol <= ?z -> [symbol]
        symbol when ?_ == symbol -> [symbol]
        symbol -> ~c""
      end
    end)
  end
end
