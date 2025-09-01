defmodule ListOps do
  # Please don't use any external modules (especially List or Enum) in your
  # implementation. The point of this exercise is to create these basic
  # functions yourself. You may use basic Kernel functions (like `Kernel.+/2`
  # for adding numbers), but please do not use Kernel functions for Lists like
  # `++`, `--`, `hd`, `tl`, `in`, and `length`.

  @spec count(list) :: non_neg_integer
  def count(list, acc\\0)
  def count([], acc), do: acc
  def count([_head|tail], acc), do: count(tail,acc+1)

  @spec reverse(list) :: list
  def reverse(l,acc\\[])
  def reverse([], acc), do: acc
  def reverse([head|tail], acc), do: reverse(tail,[head|acc])

  @spec map(list, (any -> any)) :: list
  def map([], _f), do: []
  def map([head|tail], f), do: [f.(head)| map(tail, f)]

  @spec filter(list, (any -> as_boolean(term))) :: list
  def filter([], _f), do: []
  def filter([head|tail], f) do
    if not f.(head) do
      filter(tail, f)
    else
      [head|filter(tail, f)]
    end
  end

  @type acc :: any
  @spec reduce(list, acc, (any, acc -> acc)) :: acc
  def reduce([], acc, _f), do: acc
  def reduce([head|tail], acc, f), do: reduce(tail, f.(head, acc), f)

  @spec append(list, list) :: list
  # @spec append(any, any) :: nil
  def append([],[]), do: []
  def append([], b), do: b
  def append([head|tail], b), do: [head|append(tail, b)]

  @spec concat([[any]]) :: [any]
  def concat(ll) do
    # reduce with an append funciton
    reverse(ll)|>
    reduce( [], &append/2)
  end
end
