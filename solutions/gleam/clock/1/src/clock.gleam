import gleam/int
import gleam/result
import gleam/string

const minutes_in_hour = 60

const hours_in_day = 24

const minutes_in_a_day = 1440

pub type Clock {
  Clock(hour: Int, minutes: Int)
}

pub fn create(hour hour: Int, minute minute: Int) -> Clock {
  {
    hour
    |> int.modulo(hours_in_day)
    |> result.unwrap(0)
    |> int.absolute_value
  }
  * minutes_in_hour
  + {
    minute
    |> int.modulo(minutes_in_a_day)
    |> result.unwrap(0)
    |> int.absolute_value
  }
  |> int.absolute_value
  |> int.modulo(minutes_in_a_day)
  |> result.unwrap(0)
  |> fn(x) {
    Clock(
      x |> int.divide(minutes_in_hour) |> result.unwrap(0),
      x |> int.modulo(minutes_in_hour) |> result.unwrap(0),
    )
  }
}

pub fn add(clock: Clock, minutes minutes: Int) -> Clock {
  create(
    0,
    clock.hour
    * minutes_in_hour
    + clock.minutes
    + { minutes |> int.modulo(minutes_in_a_day) |> result.unwrap(0) }
      |> int.absolute_value,
  )
}

pub fn subtract(clock: Clock, minutes minutes: Int) -> Clock {
  create(
    0,
    clock.hour
    * minutes_in_hour
    + clock.minutes
    - { minutes |> int.modulo(minutes_in_a_day) |> result.unwrap(0) }
      |> negative_to_positive(minutes_in_a_day),
  )
}

fn negative_to_positive(value: Int, modulo: Int) -> Int {
  case value < 0 {
    True -> modulo + value
    False -> value
  }
}

pub fn display(clock: Clock) -> String {
  clock.hour |> int.to_string |> string.pad_start(2, "0")
  <> ":"
  <> clock.minutes |> int.to_string |> string.pad_start(2, "0")
}
