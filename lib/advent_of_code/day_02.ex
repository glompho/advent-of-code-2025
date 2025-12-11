defmodule AdventOfCode.Day02 do
  def all_identical?([hd | rest]), do: Enum.all?(rest, &(&1 == hd))
  def all_identical?([]), do: true

  def check_invalid(number) do
    str = Integer.to_string(number)
    l = String.length(str)

    if rem(l, 2) != 0 do
      false
    else
      {first_half, second_half} = String.split_at(str, div(l, 2))

      if first_half == second_half do
        true
      else
        false
      end
    end
  end

  def check_invalid2(number) when number < 10, do: false
  def check_invalid2(number), do: check_invalid2(number, 1)

  def check_invalid2(number, split_every) do
    str = Integer.to_string(number)
    l = String.length(str)

    chunks =
      str
      |> String.graphemes()
      |> Enum.chunk_every(split_every)

    cond do
      all_identical?(chunks) -> true
      split_every + 1 > div(l, 2) -> false
      true -> check_invalid2(number, split_every + 1)
    end
  end

  def part1(input, func \\ &check_invalid/1) do
    input
    |> String.split([",", "-", "\n"], trim: true)
    |> Enum.map(&String.to_integer/1)
    |> Enum.chunk_every(2)
    |> Enum.map(fn [lb, ub] ->
      lb..ub
      |> Enum.filter(func)
      |> Enum.sum()
    end)
    |> Enum.sum()
  end

  def part2(input), do: part1(input, &check_invalid2/1)
end
