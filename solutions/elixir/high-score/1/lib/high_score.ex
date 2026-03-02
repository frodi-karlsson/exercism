defmodule HighScore do
  def new(), do: %{}
  def add_player(scores, name, score \\ 0), do: Map.put(scores, name, score)
  def remove_player(scores, name), do: Map.delete(scores, name)
  def update_score(scores, name, score) do
    {_, new_map} = Map.get_and_update(
      scores,
      name,
      &({&1, (if &1 == nil, do: score, else: score + &1)})
    )
    new_map
  end
  def reset_score(scores, name), do: Map.put(scores, name, 0)
  def get_players(scores), do: Map.keys(scores)
end
