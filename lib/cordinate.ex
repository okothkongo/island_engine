defmodule IslandsEngine.Coordinate do
  defstruct in_island: :none, guessed?: false
  alias IslandsEngine.Coordinate
  use Agent

  def start_link() do
    Agent.start_link(fn -> %Coordinate{} end)
  end

  @spec guessed?(atom | pid | {atom, any} | {:via, atom, any}) :: any
  def guessed?(coordinate) do
    Agent.get(coordinate, & &1.guessed?)
  end

  def island(coordinate) do
    Agent.get(coordinate, & &1.in_island)
  end
  def in_island?(coordinate) do
      case island(coordinate) do
          :none -> false
          _ -> true
      end
  end
  def hit?(coordinate) do
      in_island?(coordinate) && guessed?(coordinate)
  end
  def guess(coordinate) do
      Agent.update(coordinate, fn state -> Map.put( state, :guessed?, true) end)
  end
  def set_in_island(coordinate, value) when  is_atom(value) do
      Agent.update(coordinate, &(Map.put(&1, :in_island, value)))
  end
  def to_string(coordinate) do
      "in_island: #{island(coordinate)}, guessed: #{guessed?(coordinate)}"
  end
end
