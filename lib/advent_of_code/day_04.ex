defmodule AdventOfCode.Day04 do
  def make_grid(input) do
    input
    |> String.split(["\n", "\r"], trim: true)
    |> Enum.map(&String.graphemes/1)
    |> Enum.with_index()
    |> Enum.flat_map(fn {row, yindex} ->
      row
      |> Enum.with_index()
      |> Enum.map(fn {char, xindex} -> {{xindex, yindex}, char} end)
    end)
    |> Map.new()
  end

  def sum_rolls({x, y}, grid) do
    directions = [{-1, -1}, {-1, 0}, {-1, 1}, {0, -1}, {0, 1}, {1, -1}, {1, 0}, {1, 1}]

    Enum.reduce(directions, 0, fn {dx, dy}, total ->
      case grid[{x + dx, y + dy}] do
        "@" -> total + 1
        _ -> total
      end
    end)
  end

  def count_and_mark(grid) do
    Enum.reduce(Map.keys(grid), {0, grid}, fn {x, y}, {total, new_grid} ->
      if grid[{x, y}] == "@" and sum_rolls({x, y}, grid) < 4 do
        {total + 1, Map.put(new_grid, {x, y}, ".")}
      else
        {total, new_grid}
      end
    end)
  end

  def part1(input) do
    input |> make_grid() |> count_and_mark() |> elem(0)
  end

  def reduce_grid(grid, total \\ 0) do
    case count_and_mark(grid) do
      {0, _new_grid} -> total
      {count, new_grid} -> reduce_grid(new_grid, total + count)
    end
  end

  def part2(input) do
    input |> make_grid() |> reduce_grid()
  end
end
