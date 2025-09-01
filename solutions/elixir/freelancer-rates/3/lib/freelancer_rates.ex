defmodule FreelancerRates do
  def daily_rate(hourly_rate) do
    hourly_rate*8.0
  end

  def apply_discount(before_discount, discount) do
    before_discount*(100.0-discount)/100
  end

  def monthly_rate(hourly_rate, discount) do
    daily_rate(hourly_rate)*22 
    |> apply_discount(discount) 
    |> Float.ceil() 
    |> trunc() 
  end

  def days_in_budget(budget, hourly_rate, discount) do
    daily_rate(hourly_rate) 
    |> apply_discount(discount) 
    |> then (fn(amt) -> floor(budget/amt *10)/10  end)
  end
end
