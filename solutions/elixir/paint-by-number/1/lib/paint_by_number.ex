defmodule PaintByNumber do
  @number_by_color %{
    white: 0,
    black: 1,
    yellow: 2
  }
  @empty <<>>
  @test <<0::2, 1::2, 2::2, 3::2>>

  def palette_bit_size(color_count), do: palette_bit_size(color_count, 0, 0)
  defp palette_bit_size(goal_count, pos, sum) when sum >= goal_count - 1, do: pos

  defp palette_bit_size(goal_count, pos, sum),
    do: palette_bit_size(goal_count, pos + 1, sum + 2 ** pos)

  def empty_picture(), do: @empty
  def test_picture(), do: @test

  def prepend_pixel(picture, color_count, pixel_color_index) do
    <<pixel_color_index::size(palette_bit_size(color_count)), picture::bitstring>>
  end

  def get_first_pixel(picture, color_count) do
    bit_size = palette_bit_size(color_count)

    case picture do
      <<first::size(bit_size), _res::bitstring>> -> first
      _ -> nil
    end
  end

  def drop_first_pixel(picture, color_count) do
    bit_size = palette_bit_size(color_count)

    case picture do
      <<first::size(bit_size), rest::bitstring>> -> rest
      _ -> empty_picture()
    end
  end

  def concat_pictures(picture1, picture2), do: <<picture1::bitstring, picture2::bitstring>>
end
