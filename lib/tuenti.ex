defmodule Tuenti do
  @moduledoc """
  Common utilities for chellenges
  """

  def read_file(filename) do
    file = File.read!(filename)
    lines = String.split(file, "\n")
    remove_empty_lines(Enum.drop(lines, 1))
  end

  def numbers_in_line(line) do
    Enum.map(String.split(line, " "), fn(x) -> elem(Integer.parse(x), 0) end)
  end

  def print_result_line(result, line_number) do
    IO.puts "Case #" <> Integer.to_string(line_number) <> ": " <> Integer.to_string(result)
  end

  defp remove_empty_lines(list) do
     Enum.filter list, fn(x) -> x != "" end
  end
end
