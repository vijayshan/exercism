import gleam/list.{reverse}

pub fn accumulate(list: List(a), fun: fn(a) -> b) -> List(b) {
  accumulate_helper([], reverse(list), fun)
}

fn accumulate_helper(acc, list, fun) {
  case list {
    [] -> acc
    [head, ..tail] -> accumulate_helper([fun(head), ..acc], tail, fun)
  }
}
