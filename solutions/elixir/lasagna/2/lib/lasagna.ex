defmodule Lasagna do

  def expected_minutes_in_oven do
    40
  end

  def remaining_minutes_in_oven(time_spent) do
    40 - time_spent
  end


  def preparation_time_in_minutes(layers) do
    layers * 2
  end

  def total_time_in_minutes(layers, time_spent) do
    preparation_time_in_minutes(layers) + time_spent
  end

  def alarm do
    "Ding!"
  end
end
