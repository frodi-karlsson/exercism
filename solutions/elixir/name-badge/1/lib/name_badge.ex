defmodule NameBadge do
  def print(id, name, department) do
    (if id, do: ["[#{id}]"], else: [])
      ++ [name]
      ++ [String.upcase(if department, do: department, else: "owner")]
    |> Enum.join(" - ")
  end
end
