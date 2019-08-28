defmodule IslandsEngine.Island do
    use Agent
    alias IslandsEngine.Island   
    alias IslandsEngine.Coordinate 
def start_link() do
  Agent.start_link(fn -> [] end)  
end
def replace_coordinates(island, new_coordinates) when is_list(new_coordinates) do
    Agent.update(island, fn _state -> new_coordinates end)
end
def forested?(island) do
    island
    |> Agent.get(fn state -> state end)
    |> Enum.all?(fn coord -> Coordinate.hit?(coord)end)
end
def to_string(island) do
    "[" <> coordinate_strings(island) <> "]"
end
defp coordinate_strings(island) do
    island
    |> Agent.get(&(&1))
    |>Enum.map(&(Coordinate.to_string(&1)))
    |> Enum.join(", ")
end
    
end