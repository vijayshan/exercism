defmodule Markdown do
  @doc """
    Parses a given string with Markdown syntax and returns the associated HTML for that string.

    ## Examples

    iex> Markdown.parse("This is a paragraph")
    "<p>This is a paragraph</p>"

    iex> Markdown.parse("#Header!\n* __Bold Item__\n* _Italic Item_")
    "<h1>Header!</h1><ul><li><em>Bold Item</em></li><li><i>Italic Item</i></li></ul>"
  """
  # Too much going on here good place for pipes converted all the enclosed function calls to have pipes
  @spec parse(String.t()) :: String.t()
  def parse(mark_down),
    do:
      String.split(mark_down, "\n")
      |> Enum.map(&process/1)
      |> Enum.join()
      |> patch

  # the existing code had a if statement, converted it to use function guards and string
  # restructuring and also converted function calls to use pipes

  # lists
  defp process(<<start::binary-size(1), _rest::binary>> = line) when start == "*",
    do:
      parse_list_md_level(line)
      |> process_lines_for_tags

  # header
  defp process(<<start::binary-size(1), _rest::binary>> = line) when start == "#",
    do:
      parse_header_md_level(line)
      |> process_lines_for_tags

  defp process(line),
    do:
      enclose_with_tag(line, "p")
      |> process_lines_for_tags

 # the way the function was being processed the data would be 'cleaned' by
 # splitting and joining. unnecessary when we know the number of leading chars
  defp parse_header_md_level(hwt),
    do:
      String.split(hwt)
      |> (fn [h | _t] ->
            {String.length(h)
             |> to_string(), String.replace_leading(hwt, "#", "")|>String.trim()}
          end).()
      |> (fn {num, line} -> enclose_with_tag(line, "h" <> num) end).()

  # cleaned up functions made it more readable with pipe operators
  # and anonymous functions
  defp parse_list_md_level(l),
    do:
      String.trim_leading(l, "* ")
      |> enclose_with_tag("li")

  # replace_prefix_md and replace_suffix_md were unnecessarily matching regex too many times
  # instead replaced it with a clean function and use a pipe to do it right.
  defp process_lines_for_tags(line),
    do:
      search_and_replace_with_tag(line, "__", "strong")
      |> search_and_replace_with_tag("_", "em")

  # a function to check for a text pattern and then convert it in to the
  # appropriate html tag
  defp search_and_replace_with_tag(text, patt, tag) do
    Regex.replace(~r/#{patt}(.+?)#{patt}/, text, "<#{tag}>\\1</#{tag}>")
  end

  # a helper function to enclose the given term in a particular tag
  # this was being done in too many places with string concatenation when a
  # simple interpolation would have worked
  defp enclose_with_tag(w, tag), do: "<#{tag}>#{w}</#{tag}>"

  # The previous function would not have accounted for multiple lists in the same string
  # find a list of all closing </li> and startin <li> with regex, combine the list and
  # then cyle from the end to surround with <ul></ul> tags.
  def patch(l) do
    li_tags = Regex.scan(~r/<\/li>(?![\/n ]*<li>)/, l, return: :index)
    lic_tags = Regex.scan(~r/(?<!<\/li>)<li>/, l, return: :index)
    [List.flatten(li_tags),List.flatten(lic_tags)] |>
    List.zip|>
    Enum.reverse|>
    patch_helper(l)
  end

  # a helper function to process a pair of pairs. the first pair is the location and length of
  # the last </li> in a list of consecutive <li> items while the first is the location and length of
  # the first item in that block
  defp patch_helper([], acc), do: acc
  defp patch_helper([{{close_ps,close_length},{open_ps,_open_length}}|tail], acc) do
    {start, finish} = String.split_at(acc,close_ps+close_length)
    {start1, finish1} = String.split_at(start <> "</ul>" <> finish, open_ps)
    patch_helper(tail,start1<>"<ul>"<>finish1)
  end

end
