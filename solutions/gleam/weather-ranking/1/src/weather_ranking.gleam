import gleam/float
import gleam/list
import gleam/order.{type Order}

const conversion_constant: Float = 32.0

// const fahrenheit_to_celsius_multipier:Float = 5.0 /. 9.0

pub type City {
  City(name: String, temperature: Temperature)
}

pub type Temperature {
  Celsius(Float)
  Fahrenheit(Float)
}

pub fn fahrenheit_to_celsius(f: Float) -> Float {
  { f -. conversion_constant } *. 5.0 /. 9.0
}

fn normalise(temperature: Temperature) -> Float {
  case temperature {
    Celsius(k) -> k
    Fahrenheit(k) -> fahrenheit_to_celsius(k)
  }
}

pub fn compare_temperature(left: Temperature, right: Temperature) -> Order {
  let normalised_left = normalise(left)
  let normalised_right = normalise(right)
  float.compare(normalised_left, normalised_right)
}

pub fn sort_cities_by_temperature(cities: List(City)) -> List(City) {
  list.sort(cities, fn(a, b) {
    compare_temperature(a.temperature, b.temperature)
  })
}
