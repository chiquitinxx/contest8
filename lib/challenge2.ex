defmodule Challenge2 do
  @moduledoc """
  Challenge 2 - Hidden numbers
  """

  def solve(filename) do
    lines_size = Tuenti.read_file(filename) |> Enum.map(&String.length/1)
    result = Enum.map(lines_size, fn size -> diference_max_min(size) end)
    
    Tuenti.print_result(result)
  end

  defp diference_max_min(size) when size < 3 do
    0.0
  end

  defp diference_max_min(size) do
    max(size) - min(size)
  end

  defp max(size) do
    make_sum((size - 1)..0, size)
  end

  defp min(size) do
    make_sum(Enum.concat(1..0, 2..(size - 1)), size)
  end

  defp make_sum(numbers, size) do
    numbers
    |> Enum.map_reduce(:math.pow(size, size - 1), fn x, acc -> reductor(x, acc, size) end)
    |> elem(0)
    |> Enum.sum()   
  end

  defp reductor(x, acc, size) do
    {x * acc, acc / size}  
  end
end
