defmodule AdventOfCode.Day03 do
  def get_joltage(bank), do: get_joltage(bank, 0, 0)

  def get_joltage(_bank = [hd], max_a, max_b) do
    (max_a <> max(hd, max_b)) |> String.to_integer()
  end

  def get_joltage(_bank = [hd | rest], max_a, max_b) do
    cond do
      hd > max_a -> get_joltage(rest, hd, 0)
      hd > max_b -> get_joltage(rest, max_a, hd)
      true -> get_joltage(rest, max_a, max_b)
    end
  end

  def part1(input) do
    input
    |> String.split(["\n"], trim: true)
    |> Enum.map(&String.graphemes/1)
    |> Enum.map(&get_joltage/1)
    |> Enum.sum()
  end

  def part2(_input) do
  end
end
