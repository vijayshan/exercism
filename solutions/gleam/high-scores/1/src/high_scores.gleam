import gleam/int
import gleam/list

pub fn scores(high_scores: List(Int)) -> List(Int) {
  high_scores
}

pub fn latest(high_scores: List(Int)) -> Result(Int, Nil) {
  case list.last(high_scores) {
    Ok(score) -> score |> Ok
    _ -> Nil |> Error
  }
}

pub fn personal_best(high_scores: List(Int)) -> Result(Int, Nil) {
  high_scores
  |> list.reduce(fn(acc, x) {
    case acc < x {
      True -> x
      False -> acc
    }
  })
}

pub fn personal_top_three(high_scores: List(Int)) -> List(Int) {
  high_scores |> list.sort(int.compare) |> list.reverse |> list.take(3)
}
