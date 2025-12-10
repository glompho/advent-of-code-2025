defmodule AdventOfCode.Day01 do
  def parse(input) do
    input
    |> String.split(["\n", "\r"], trim: true)
    |> Enum.map(fn
      "R" <> num -> String.to_integer(num)
      "L" <> num -> String.to_integer(num) * -1
    end)
  end

  def part1(input) do
    input
    |> parse()
    |> Enum.reduce([50, 0], fn elem, [total, zero_count] ->
      new_total = Integer.mod(total + elem, 100)

      if new_total == 0 do
        [new_total, zero_count + 1]
      else
        [new_total, zero_count]
      end
    end)
    |> Enum.at(1)
  end

  def part2(input) do
    input
    |> parse()
    |> Enum.reduce([50, 0], fn elem, [total, zero_count] ->
      nt = total + elem
      turns = nt |> div(100) |> abs

      if nt <= 0 and total != 0 do
        [Integer.mod(nt, 100), zero_count + turns + 1]
      else
        [Integer.mod(nt, 100), zero_count + turns]
      end
    end)
    |> Enum.at(1)
  end
end
