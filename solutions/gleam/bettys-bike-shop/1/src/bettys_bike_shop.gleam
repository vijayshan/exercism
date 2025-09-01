import gleam/float
import gleam/int
import gleam/string

const pound_to_pence: Float = 100.0

const pound_sign: String = "£"

pub fn pence_to_pounds(pence: Int) -> Float {
  int.to_float(pence) /. pound_to_pence
}

pub fn pounds_to_string(pounds: Float) {
  string.append(pound_sign, float.to_string(pounds))
}
