import gleam/list

pub fn rows(n: Int) -> List(List(Int)) {
  case n <= 0 {
    True -> []
    False -> construct_pascal(n, []) |> list.reverse
  }
}

fn construct_pascal(target_rows: Int, acc: List(List(Int))) -> List(List(Int)) {
  let current_count = list.length(acc)

  case current_count >= target_rows {
    True -> acc
    False -> {
      let new_row = case current_count {
        0 -> [1]
        _ -> {
          let last_row = case list.first(acc) {
            Ok(row) -> row
            Error(_) -> [1]
          }
          build_new_row(last_row)
        }
      }
      construct_pascal(target_rows, [new_row, ..acc])
    }
  }
}

fn build_new_row(last_row: List(Int)) -> List(Int) {
  let first_element = 1
  let last_element = 1
  let middle_elements =
    list.window_by_2(last_row)
    |> list.map(fn(item: #(Int, Int)) {
      let #(a, b) = item
      a + b
    })
  [
    first_element,
    ..[last_element, ..middle_elements |> list.reverse()]
    |> list.reverse
  ]
}
