defmodule Rules do

  def eat_ghost?(true, true), do: true
  def eat_ghost?(_, _), do: false

  def score?(true, _), do: true
  def score?(_, true), do: true
  def score?(_, _), do: false

  def lose?(false, true), do: true
  def lose?(_, _), do: false

  def win?(true, _, false), do: true
  def win?(true, true, true), do: true
  def win?(_,_,_), do: false

end
