import gleam/list

pub fn place_location_to_treasure_location(
  place_location: #(String, Int),
) -> #(Int, String) {
  let #(place, location) = place_location
  #(location, place)
}

pub fn treasure_location_matches_place_location(
  place_location: #(String, Int),
  treasure_location: #(Int, String),
) -> Bool {
  place_location_to_treasure_location(place_location) == treasure_location
}

pub fn count_place_treasures(
  place: #(String, #(String, Int)),
  treasures: List(#(String, #(Int, String))),
) -> Int {
  let treasure_location = place_location_to_treasure_location(place.1)
  treasures
  |> list.filter(fn(item) {
    case item {
      #(_, treasure) if treasure == treasure_location -> True
      _ -> False
    }
  })
  |> list.length
}

pub fn special_case_swap_possible(
  found_treasure: #(String, #(Int, String)),
  place: #(String, #(String, Int)),
  desired_treasure: #(String, #(Int, String)),
) -> Bool {
  case found_treasure, place, desired_treasure {
    #("Amethyst Octopus", #(1, "F")),
      #("Stormy Breakwater", #("B", 5)),
      #("Glass Starfish", #(6, "D"))
    | #("Vintage Pirate Hat", #(7, "E")),
      #("Harbor Managers Office", #("A", 8)),
      #("Model Ship in Large Bottle", #(8, "A"))
    | #("Vintage Pirate Hat", #(7, "E")),
      #("Harbor Managers Office", #("A", 8)),
      #("Antique Glass Fishnet Float", #(3, "D"))
    | #("Amethyst Octopus", #(1, "F")),
      #("Stormy Breakwater", #("B", 5)),
      #("Crystal Crab", #(6, "A"))
    -> True
    _, _, _ -> False
  }
}
