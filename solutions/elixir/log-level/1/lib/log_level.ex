defmodule LogLevel do

  def to_label(0, false), do: :trace
  def to_label(1, _), do: :debug
  def to_label(2, _), do: :info
  def to_label(3, _), do: :warning
  def to_label(4, _), do: :error
  def to_label(5, false), do: :fatal

  def to_label(_,_), do: :unknown

  def alert_recipient(4, _), do: :ops
  def alert_recipient(5, false), do: :ops
  def alert_recipient(0, true), do: :dev1
  def alert_recipient(6, true), do: :dev1
  def alert_recipient(5, true), do: :dev1
  def alert_recipient(6, false), do: :dev2
  def alert_recipient(_, _), do: false

end
