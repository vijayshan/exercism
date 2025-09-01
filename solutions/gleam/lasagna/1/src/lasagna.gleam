const cooking_time: Int = 40

const cooking_time_per_layer: Int = 2

pub fn expected_minutes_in_oven() -> Int {
  cooking_time
}

pub fn remaining_minutes_in_oven(time: Int) -> Int {
  expected_minutes_in_oven() - time
}

pub fn preparation_time_in_minutes(layers: Int) -> Int {
  layers * cooking_time_per_layer
}

pub fn total_time_in_minutes(layers: Int, time: Int) -> Int {
  preparation_time_in_minutes(layers) + time
}

pub fn alarm() -> String {
  "Ding!"
}
