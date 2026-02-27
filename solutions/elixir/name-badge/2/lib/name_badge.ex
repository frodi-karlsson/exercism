defmodule NameBadge do
  def print(id, name, department) do
    parts = [(if department, do: String.upcase(department), else: "OWNER")]
    parts = [name | parts]
    parts = if id, do: ["[#{id}]" | parts], else: parts
    Enum.join(parts, " - ")
  end
end
