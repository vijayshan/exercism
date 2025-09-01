import gleam/list

pub fn rows(n: Int) -> List(List(Int)) {
  construct_pascal(n, [])
}

fn construct_pascal(index: Int, acc: List(List(Int))) -> List(List(Int)) {
  case index {
    0 -> list.append(acc, [])
    1 -> list.append(acc, [[1]])
    2 -> list.append(acc, [[1], [1, 1]])
    _ -> {
      let previous_rows = construct_pascal(index - 1, acc)
      let last_row = case list.last(previous_rows) {
        Ok(last_row) -> last_row
        Error(_) -> []
      }
      let new_row = build_new_row(last_row)
      list.append(previous_rows, [new_row])
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
  list.append([first_element], list.append(middle_elements, [last_element]))
}
