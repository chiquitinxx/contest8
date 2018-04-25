defmodule Challenge1 do
  @moduledoc """
  Challenge 1 - Waffle love
  """

  def solve(filename) do
    lines = Tuenti.read_file(filename) |> Enum.map(&Tuenti.numbers_in_line/1)
    result = Enum.map(lines, fn line -> calculate_holes(line) end)

    Tuenti.print_result(result)
  end

  def calculate_holes([horizontal, vertical]) do
    (horizontal - 1) * (vertical - 1)
  end
end
