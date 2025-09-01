defmodule Strain do
  @doc """
  Given a `list` of items and a function `fun`, return the list of items where
  `fun` returns true.

  Do not use `Enum.filter`.
  """
  @spec keep(list :: list(any), fun :: (any -> boolean)) :: list(any)
  def keep(list,_) when length(list)==0, do: []
  def keep(list, fun) do
    util(list, fun, fn x -> x end)
  end

  @doc """
  Given a `list` of items and a function `fun`, return the list of items where
  `fun` returns false.

  Do not use `Enum.reject`.
  """
  @spec discard(list :: list(any), fun :: (any -> boolean)) :: list(any)
  def discard(list,_) when length(list)==0, do: []
  def discard(list, fun) do
    util(list, fun, fn x -> !x end)
  end

  @doc """
  Given a `list` of items and  functions `fun` and `checker`, return the list of items where
  `checker(fun)` returns true .
  """
  @spec util(list :: list(any), fun :: (any -> boolean), checker :: (boolean->boolean)) :: list(any)
  def util(list, _, _) when length(list)==0, do: []
  def util(list, fun, checker) do
    [head|tail] = list
    if checker.(fun.(head)) do
     Enum.concat([head], util(tail, fun, checker))
    else
      util(tail,fun,checker)
    end  
  end
end
