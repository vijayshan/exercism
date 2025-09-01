defmodule FlattenArray do
  @doc """
    Accept a list and return the list flattened without nil values.

    ## Examples

      iex> FlattenArray.flatten([1, [2], 3, nil])
      [1,2,3]

      iex> FlattenArray.flatten([nil, nil])
      []

  """

  @spec flatten(list) :: list
  def flatten(list, acc \\ [])

  def flatten([], acc), do: acc

  def flatten([head | tail], acc) when is_list(head) do
    flatten(tail, acc ++ flatten(head, []))
  end

  def flatten([head | tail], acc) when is_nil(head) do
    flatten(tail, acc)
  end

  def flatten([head | tail], acc) do
    flatten(tail, acc ++ [head])
  end
end
