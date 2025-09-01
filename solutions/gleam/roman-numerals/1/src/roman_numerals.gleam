import gleam/string

pub fn convert(number: Int) -> String {
  let str = case number {
    //number in billions
    number if number >= 1000 ->
      string.repeat("M", number / 1000) <> convert(number % 1000)
    number if number >= 100 && number < 1000 ->
      translate(number, "M", "D", "C", 100) <> convert(number % 100)
    number if number >= 10 && number < 100 ->
      translate(number, "C", "L", "X", 10) <> convert(number % 10)
    number if number < 10 -> translate(number, "X", "V", "I", 1)
    _ -> ""
  }

  str
}

fn translate(number, max, mid, prev_max, division) -> String {
  case number / division {
    9 -> prev_max <> max
    number if number >= 5 && number <= 8 ->
      mid <> string.repeat(prev_max, { number - 5 })
    4 -> prev_max <> mid
    number if number > 0 && number <= 3 -> string.repeat(prev_max, number)
    _ -> ""
  }
}
