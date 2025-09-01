import gleam/list

pub fn wines_of_color(wines wines: List(Wine), color color: Color) -> List(Wine) {
  wines |> list.filter(fn(x) { x.color == color })
}

pub fn wines_from_country(
  wines wines: List(Wine),
  country country: String,
) -> List(Wine) {
  wines |> list.filter(fn(x) { x.country == country })
}

pub fn filter(
  wines wines: List(Wine),
  country country: String,
  color color: Color,
) -> List(Wine) {
  wines |> wines_from_country(country: country) |> wines_of_color(color: color)
}

pub type Wine {
  Wine(name: String, year: Int, country: String, color: Color)
}

pub type Color {
  Red
  Rose
  White
}
