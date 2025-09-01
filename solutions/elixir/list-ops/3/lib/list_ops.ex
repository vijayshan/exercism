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
  def map(l,f,acc\\[])
  def map([], _f, acc), do: reverse(acc)
  def map([head|tail], f, acc), do: map(tail,f, [f.(head)| acc])

  @spec filter(list, (any -> as_boolean(term))) :: list
  def filter(l, f, acc\\[])
  def filter([], _f, acc), do: reverse(acc)
  def filter([head|tail], f, acc), do: if not f.(head), do: filter(tail, f, acc), else: filter(tail, f, [head|acc])

  @type acc :: any
  @spec reduce(list, acc, (any, acc -> acc)) :: acc
  def reduce([], acc, _f), do: acc
  def reduce([head|tail], acc, f), do: reduce(tail, f.(head, acc), f)

  #could not tail call optimize.
  @spec append(list, list) :: list
  def append([],[]), do: []
  def append([], b), do: b
  def append([head|tail], b), do: [head|append(tail, b)]

  @spec concat([[any]]) :: [any]
  def concat(ll), do: reverse(ll)|>reduce( [], &append/2)
end
