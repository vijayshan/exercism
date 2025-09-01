defmodule LogLevel do

  # def to_label(0, false), do: :trace
  # def to_label(1, _), do: :debug
  # def to_label(2, _), do: :info
  # def to_label(3, _), do: :warning
  # def to_label(4, _), do: :error
  # def to_label(5, false), do: :fatal

  def to_label(level, legacy?) do
    cond do
      level==0 and not legacy? -> :trace
      level == 1 -> :debug
      level == 2 -> :info
      level == 3 -> :warning
      level == 4 -> :error
      level == 5 and not legacy? -> :fatal
      true -> :unknown
    end
  end

  @spec alert_recipient(any, any) :: :dev1 | :dev2 | false | :ops
  def alert_recipient(level, legacy?) do
    label = to_label(level, legacy?)
    cond do
      label == :error or label == :fatal -> :ops
      label == :unknown and legacy? -> :dev1
      label == :unknown and not legacy? -> :dev2
      true -> false
    end
  end

end
