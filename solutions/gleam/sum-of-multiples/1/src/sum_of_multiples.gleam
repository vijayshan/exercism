import gleam/list
import gleam/set

pub fn sum(factors factors: List(Int), limit limit: Int) -> Int {
  factors
  |> list.filter(fn(a) { a < limit })
  |> list.map(fn(factor) { list.range(factor, limit - 1) })
  |> list.map(fn(a) {
    case list.first(a) {
      Ok(a1) if a1 != 0 ->
        set.from_list(list.filter(a, fn(a2) { a2 % a1 == 0 }))
      _ -> set.from_list([])
    }
  })
  |> list.fold(set.from_list([]), fn(b, a) { set.union(b, a) })
  |> set.to_list
  |> list.fold(0, fn(a, b) { a + b })
}
