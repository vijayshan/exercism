import gleam/list

pub type Triplet {
  Triplet(Int, Int, Int)
}

pub fn triplets_with_sum(sum: Int) -> List(Triplet) {
  let limit = sum
  let a_list = list.range(1, limit / 3)

  list.fold(a_list, [], fn(list_b, num_a) {
    list.fold(list.range(num_a + 1, limit / 2), list_b, fn(list_c, num_b) {
      case num_a, num_b, limit - num_a - num_b {
        x, y, z if x * x + y * y == z * z -> [
          Triplet(num_a, num_b, limit - num_a - num_b),
          ..list_c
        ]
        _, _, _ -> list_c
      }
    })
  })
  |> list.reverse
}
