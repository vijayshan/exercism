import gleam/list
import gleam/set.{type Set}
import gleam/string

pub fn new_collection(card: String) -> Set(String) {
  set.from_list([card])
}

pub fn add_card(collection: Set(String), card: String) -> #(Bool, Set(String)) {
  case set.contains(collection, card) {
    True -> #(True, collection)
    False -> #(False, set.insert(collection, card))
  }
}

pub fn trade_card(
  my_card: String,
  their_card: String,
  collection: Set(String),
) -> #(Bool, Set(String)) {
  case set.contains(collection, my_card), set.contains(collection, their_card) {
    True, False -> #(
      True,
      collection |> set.delete(my_card) |> set.insert(their_card),
    )
    _, _ -> #(
      False,
      collection |> set.delete(my_card) |> set.insert(their_card),
    )
  }
}

pub fn boring_cards(collections: List(Set(String))) -> List(String) {
  case collections {
    [h, ..t] ->
      list.fold_right(t, h |> set.to_list, fn(common_list, new_set) {
        common_list |> set.from_list |> set.intersection(new_set) |> set.to_list
      })
    _ -> []
  }
}

pub fn total_cards(collections: List(Set(String))) -> Int {
  case collections {
    [h, ..t] ->
      list.fold_right(t, h |> set.to_list, fn(union_list, new_set) {
        union_list |> set.from_list |> set.union(new_set) |> set.to_list
      })
      |> list.length
    _ -> 0
  }
}

pub fn shiny_cards(collection: Set(String)) -> Set(String) {
  collection |> set.filter(fn(card) { card |> string.contains("Shiny ") })
}
