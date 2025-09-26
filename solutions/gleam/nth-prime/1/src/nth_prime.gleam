import gleam/bool
import gleam/float
import gleam/int
import gleam/list
import gleam/result

pub fn prime(n: Int) -> Result(Int, Nil) {
  case n {
    x if x < 1 -> Error(Nil)
    _ -> generate_nth_prime(2, n) |> Ok
  }
}

fn generate_nth_prime(candidate: Int, remaining: Int) -> Int {
  case is_prime(candidate) {
    True if remaining == 1 -> candidate
    True -> generate_nth_prime(candidate + 1, remaining - 1)
    False -> generate_nth_prime(candidate + 1, remaining)
  }
}

fn is_prime(number: Int) -> Bool {
  case number {
    x if x < 2 -> False
    2 -> True
    x if x % 2 == 0 -> False
    _ -> {
      number
      |> int.square_root
      |> result.unwrap(1.0)
      |> float.truncate
      |> fn(x) {
        case number, x {
          3, _ -> []
          //edge case for 3
          _, x if x <= 3 -> [3]
          _, _ -> list.range(3, x)
        }
      }
      |> list.filter(fn(x) { x % 2 != 0 })
      |> list.any(fn(x) { number % x == 0 })
      |> bool.negate
    }
  }
}
