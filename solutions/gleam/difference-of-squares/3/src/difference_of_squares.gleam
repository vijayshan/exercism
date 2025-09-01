import gleam/list

fn n_natural(n: Int) -> List(Int) {
  list.range(1, n)
}

pub fn square_of_sum(n: Int) -> Int {
  n_natural(n)
  |> list.fold_right(0, fn(prev, curr) { prev + curr })
  |> fn(x) { x * x }
}

pub fn sum_of_squares(n: Int) -> Int {
  n_natural(n)
  |> list.map(fn(x) { x * x })
  |> list.fold_right(0, fn(prev, curr) { prev + curr })
}

pub fn difference(n: Int) -> Int {
  square_of_sum(n) - sum_of_squares(n)
}
