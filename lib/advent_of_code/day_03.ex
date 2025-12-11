defmodule AdventOfCode.Day03 do
  def get_joltage_old(bank), do: get_joltage(bank, 0, 0)

  def get_joltage_old(_bank = [hd], max_a, max_b) do
    (max_a <> max(hd, max_b)) |> String.to_integer()
  end

  def get_joltage_old(_bank = [hd | rest], max_a, max_b) do
    cond do
      hd > max_a -> get_joltage(rest, hd, 0)
      hd > max_b -> get_joltage(rest, max_a, hd)
      true -> get_joltage(rest, max_a, max_b)
    end
  end

  def replace_and_zero([h | t], new_value) do
    if new_value > h do
      zeros = Enum.map(t, fn _ -> 0 end)
      [new_value | zeros]
    else
      [h | replace_and_zero(t, new_value)]
    end
  end

  def replace_and_zero([], _new_value), do: []

  def get_joltage(bank, jolt_size) do
    empty_joltage = List.duplicate(0, jolt_size)
    bank = Enum.map(bank, &String.to_integer/1)
    get_joltage(bank, jolt_size, empty_joltage)
  end

  def get_joltage(_bank = [hd | rest], jolt_size, joltage) when length(rest) < jolt_size do
    offset = max(jolt_size - length(rest), 0)

    {pre, section} = Enum.split(joltage, offset - 1)

    new_section = replace_and_zero(section, hd)

    get_joltage(rest, jolt_size, Enum.concat(pre, new_section))
  end

  def get_joltage(_bank = [hd | rest], jolt_size, joltage) do
    new_joltage = replace_and_zero(joltage, hd)
    get_joltage(rest, jolt_size, new_joltage)
  end

  def get_joltage([], _jolt_size, joltage), do: Integer.undigits(joltage)

  def part1(input, jolt_size \\ 2) do
    input
    |> String.split(["\n"], trim: true)
    |> Enum.map(&String.graphemes/1)
    |> Enum.map(&get_joltage(&1, jolt_size))
    |> Enum.sum()
  end

  def part2(input), do: part1(input, 12)
end
