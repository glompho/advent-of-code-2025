defmodule AdventOfCode.Day01Test do
  use ExUnit.Case

  import AdventOfCode.Day01

  test "part1" do
    input = "L68
L30
R48
L5
R60
L55
L1
L99
R14
L82"
    result = part1(input)

    assert result == 3
  end

  test "part2" do
    input = "L68
L30
R48
L5
R60
L55
L1
L99
R14
L82"
    result = part2(input)

    assert result == 6
  end

  @tag :skip
  test "part2_2" do
    input = "L1000"
    result = part2(input)

    assert result == 10
  end
end
