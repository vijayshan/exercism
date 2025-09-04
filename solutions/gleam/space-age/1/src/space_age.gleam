pub type Planet {
  Mercury
  Venus
  Earth
  Mars
  Jupiter
  Saturn
  Uranus
  Neptune
}

const seconds_per_earth_year = 31_557_600.0

pub fn age(planet: Planet, seconds: Float) -> Float {
  let years = seconds /. seconds_per_earth_year
  case planet {
    Mercury -> years /. 0.2408467
    Venus -> years /. 0.61519726
    Earth -> years /. 1.0
    Mars -> years /. 1.8808158
    Jupiter -> years /. 11.862615
    Saturn -> years /. 29.447498
    Uranus -> years /. 84.016846
    Neptune -> years /. 164.7913
  }
}
