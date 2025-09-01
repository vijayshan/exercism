defmodule FreelancerRates do
  @hours_per_day 8.0
  @days_per_week 22
  @perc 100.0

  def daily_rate(hourly_rate) do
    hourly_rate * @hours_per_day
  end

  def apply_discount(before_discount, discount) do
    before_discount * (@perc - discount) / @perc
  end

  def monthly_rate(hourly_rate, discount) do
    hourly_rate
    |> Kernel.*(@days_per_week)
    |> daily_rate()
    |> apply_discount(discount)
    |> Float.ceil()
    |> trunc()
  end

  def days_in_budget(budget, hourly_rate, discount) do
    discounted_hourly_rate =
      hourly_rate
      |> daily_rate()
      |> apply_discount(discount)

    budget
    |> Kernel./(discounted_hourly_rate)
    |> Float.floor(1)
  end
end
