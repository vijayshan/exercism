import gleam/list

fn n_natural(n: Int) -> List(Int) {
  list.range(1, n)
}

pub fn square_of_sum(n: Int) -> Int {
  let number_list = n_natural(n)
  let sum = list.fold_right(number_list, 0, fn(prev, curr) { prev + curr })
  sum * sum
}

pub fn sum_of_squares(n: Int) -> Int {
  let number_list = n_natural(n)
  list.fold_right(number_list, 0, fn(prev, curr) { prev + curr * curr })
}

pub fn difference(n: Int) -> Int {
  square_of_sum(n) - sum_of_squares(n)
}
