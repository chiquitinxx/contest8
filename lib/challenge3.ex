defmodule Challenge3 do
  @moduledoc """
  Challenge 3 - Scales
  """

  @simplification [
    {"Ab", "G#"},
    {"Bb", "A#"},
    {"Cb", "B"},
    {"Db", "C#"},
    {"Eb", "D#"},
    {"Fb", "E"},
    {"Gb", "F#"},
    {"B#", "C"},
    {"E#", "F"}
  ]

  @scales [
    {"MA", ["A", "B", "C#", "D", "E", "F#", "G#"]},
    {"MA#", ["A#", "C", "D", "D#", "F", "G", "A"]},
    {"MB", ["B", "C#", "D#", "E", "F#", "G#", "A#"]},
    {"MC", ["C", "D", "E", "F", "G", "A", "B"]},
    {"MC#", ["C#", "D#", "F", "F#", "G#", "A#", "C"]},
    {"MD", ["D", "E", "F#", "G", "A", "B", "C#"]},
    {"MD#", ["D#", "F", "G", "G#", "A#", "C", "D"]},
    {"ME", ["E", "F#", "G#", "A", "B", "C#", "D#"]},
    {"MF", ["F", "G", "A", "A#", "C", "D", "E"]},
    {"MF#", ["F#", "G#", "A#", "B", "C#", "D#", "F"]},
    {"MG", ["G", "A", "B", "C", "D", "E", "F#"]},
    {"MG#", ["G#", "A#", "C", "C#", "D#", "F", "G"]},
    {"mA", ["A", "B", "C", "D", "E", "F", "G"]},
    {"mA#", ["A#", "C", "C#", "D#", "F", "F#", "G#"]},
    {"mB", ["B", "C#", "D", "E", "F#", "G", "A"]},
    {"mC", ["C", "D", "D#", "F", "G", "G#", "A#"]},
    {"mC#", ["C#", "D#", "E", "F#", "G#", "A", "B"]},
    {"mD", ["D", "E", "F", "G", "A", "A#", "C"]},
    {"mD#", ["D#", "F", "F#", "G#", "A#", "B", "C#"]},
    {"mE", ["E", "F#", "G", "A", "B", "C", "D"]},
    {"mF", ["F", "G", "G#", "A#", "C", "C#", "D#"]},
    {"mF#", ["F#", "G#", "A", "B", "C#", "D", "E"]},
    {"mG", ["G", "A", "A#", "C", "D", "D#", "F"]},
    {"mG#", ["G#", "A#", "B", "C#", "D#", "E", "F#"]}
  ]

  def solve(filename) do
    lines = Tuenti.read_file(filename)
    result = process_lines(lines, [])
    # Enum.each @scales, fn x -> IO.puts(elem(x, 0)) end
    Tuenti.print_result(result)
  end

  defp process_lines([], results) do
    results
  end

  defp process_lines([number | rest], results) do
    value = Integer.parse(number) |> elem(0)

    case value do
      0 ->
        process_lines(
          rest,
          results ++ [Enum.map(@scales, fn {name_scale, _notes} -> name_scale end)]
        )

      _ ->
        process_lines(Enum.drop(rest, 1), results ++ [scales_of_notes(Enum.at(rest, 0))])
    end
  end

  defp scales_of_notes(string_notes) do
    all_notes_simplified =
      String.splitter(String.trim(string_notes), [" "]) |> Enum.map(&simplify/1)

    scales =
      Enum.filter(@scales, fn {_name_scale, notes} ->
        Enum.count(all_notes_simplified, fn note ->
          Enum.member?(notes, note)
        end) == Enum.count(all_notes_simplified)
      end)

    case scales do
      [] -> ["None"]
      x -> x |> Enum.map(fn {name_scale, _notes} -> name_scale end)
    end
  end

  defp simplify(note) do
    Enum.find(@simplification, {note, note}, fn {unused, _used} -> unused == note end) |> elem(1)
  end
end
