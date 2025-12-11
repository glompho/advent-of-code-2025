defmodule AdventOfCode.Day03Test do
  use ExUnit.Case

  import AdventOfCode.Day03

  test "part1" do
    input = "987654321111111
811111111111119
234234234234278
818181911112111"
    result = part1(input)

    assert result == 357
  end

  test "part2" do
    input = "987654321111111
811111111111119
234234234234278
818181911112111"
    result = part2(input)

    assert result == 3_121_910_778_619
  end
end
