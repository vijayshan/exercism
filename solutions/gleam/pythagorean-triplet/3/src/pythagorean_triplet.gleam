import gleam/list

pub type Triplet {
  Triplet(Int, Int, Int)
}

pub fn triplets_with_sum(sum: Int) -> List(Triplet) {
  let limit = sum
  // let a_list = 

  list.range(limit / 3, 1)
  |> list.fold([], fn(list_b, num_a) {
    list.range(limit / 2, num_a + 1)
    |> list.fold(list_b, fn(list_c, num_b) {
      case num_a, num_b, limit - num_a - num_b {
        x, y, z if x * x + y * y == z * z -> [
          Triplet(num_a, num_b, limit - num_a - num_b),
          ..list_c
        ]
        _, _, _ -> list_c
      }
    })
  })
}
