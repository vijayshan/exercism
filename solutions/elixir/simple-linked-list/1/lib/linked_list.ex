defmodule LinkedList do
  @opaque t :: tuple()

  @doc """
  Construct a new LinkedList
  """
  @spec new() :: t
  def new() do
    {nil, nil}
  end

  @doc """
  Push an item onto a LinkedList
  """
  @spec push(t, any()) :: t
  def push({nil, nil}, elem), do: {elem, new()}
  def push(list, elem), do: {elem, list}

  @doc """
  Calculate the length of a LinkedList
  """
  @spec length(t) :: non_neg_integer()
  def length(list, count \\ 0)
  def length({nil, nil}, count), do: count

  def length({_item, next}, count) do
    length(next, count + 1)
  end

  @doc """
  Determine if a LinkedList is empty
  """
  @spec empty?(t) :: boolean()
  def empty?({nil, nil}), do: true
  def empty?(_list), do: false

  @doc """
  Get the value of a head of the LinkedList
  """
  @spec peek(t) :: {:ok, any()} | {:error, :empty_list}
  def peek({nil, nil}), do: {:error, :empty_list}
  def peek({elem, _next}), do: {:ok, elem}

  @doc """
  Get tail of a LinkedList
  """
  @spec tail(t) :: {:ok, t} | {:error, :empty_list}
  def tail({nil, nil}), do: {:error, :empty_list}
  def tail({_elem, next}), do: {:ok, next}

  @doc """
  Remove the head from a LinkedList
  """
  @spec pop(t) :: {:ok, any(), t} | {:error, :empty_list}
  def pop({nil, nil}), do: {:error, :empty_list}
  def pop({item, next}), do: {:ok, item, next}

  @doc """
  Construct a LinkedList from a stdlib List
  """
  @spec from_list(list(), t) :: t
  def from_list(list, linked_list \\ new())
  def from_list([], linked_list), do: linked_list
  def from_list([head | tail], linked_list), do: push(from_list(tail, linked_list), head)

  @doc """
  Construct a stdlib List LinkedList from a LinkedList
  """
  @spec to_list(t, list()) :: list()
  def to_list(linked_list, list \\ [])
  def to_list({nil, nil}, list), do: Enum.reverse(list)
  def to_list({elem, next}, list), do: to_list(next, [elem | list])

  @doc """
  Reverse a LinkedList
  """
  @spec reverse(t, t) :: t
  def reverse(linked_list, linked_list_new \\ new())
  def reverse({nil, nil}, linked_list_new), do: linked_list_new
  def reverse({elem, next}, linked_list_new), do: reverse(next, push(linked_list_new, elem))
end
