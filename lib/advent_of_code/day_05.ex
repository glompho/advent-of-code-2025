defmodule AdventOfCode.Day05 do
  def parse(input) do
    [ranges, ids] =
      String.split(input, "\n\n")
      |> Enum.map(fn section ->
        section
        |> String.split(["\n", "\r", "-"], trim: true)
        |> Enum.map(&String.to_integer/1)
      end)

    {Enum.chunk_every(ranges, 2), ids}
  end

  def part1(input) do
    {ranges, ids} = parse(input)

    Enum.count(ids, fn id ->
      Enum.any?(ranges, fn [low, high] -> id >= low and id <= high end)
    end)
  end

  def part2(input) do
    {ranges, _ids} = parse(input)

    ranges
    |> Enum.sort()
    |> Enum.reduce([], fn
      [low, high], [] ->
        [[low, high]]

      [low, high], [[lastlow, lasthigh] | rest] ->
        cond do
          low > lasthigh -> [[low, high], [lastlow, lasthigh] | rest]
          low <= lasthigh -> [[lastlow, max(high, lasthigh)] | rest]
        end
    end)
    |> Enum.sum_by(fn [low, high] -> high + 1 - low end)
  end
end
