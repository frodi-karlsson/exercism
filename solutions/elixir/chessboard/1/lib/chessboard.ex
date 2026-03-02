defmodule Chessboard do
  @rank_range 1..8
  @file_range ?A..?H
  def rank_range, do: @rank_range

  def file_range, do: @file_range

  def ranks, do: rank_range() |> Range.to_list()

  def files, do: file_range() |> Range.to_list() |> Enum.map(&<<&1>>)
end
