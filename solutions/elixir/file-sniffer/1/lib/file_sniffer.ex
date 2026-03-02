defmodule FileSniffer do
  @extension_to_file_type %{
    "exe" => :ELF,
    "bmp" => :BMP,
    "png" => :PNG,
    "jpg" => :JPG,
    "gif" => :GIF
  }

  @file_type_to_media_type %{
    ELF: "application/octet-stream",
    BMP: "image/bmp",
    PNG: "image/png",
    JPG: "image/jpg",
    GIF: "image/gif",
  }
  def type_from_extension(extension) do
    extension
    |> String.downcase()
    |> then(&(@file_type_to_media_type[@extension_to_file_type[&1]]))
  end

  def type_from_binary(<<0x7F, 0x45, 0x4C, 0x46, _rest::binary>>), do: @file_type_to_media_type[:ELF]
  def type_from_binary(<<0x42, 0x4D, _rest::binary>>), do: @file_type_to_media_type[:BMP]
  def type_from_binary(<<0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A, _rest::binary>>), do: @file_type_to_media_type[:PNG]
  def type_from_binary(<<0xFF, 0xD8, 0xFF, _rest::binary>>), do: @file_type_to_media_type[:JPG]
  def type_from_binary(<<0x47, 0x49, 0x46, _rest::binary>>), do: @file_type_to_media_type[:GIF]
  def type_from_binary(_), do: nil

  def verify(file_binary, extension) do
    case {type_from_extension(extension), type_from_binary(file_binary)} do
      {type, type} when not is_nil(type)  -> {:ok, type}
      _ -> {:error, "Warning, file format and file extension do not match."}
    end
  end
end
