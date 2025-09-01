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
  case found_treasure.0, place.0, desired_treasure.0 {
    "Amethyst Octopus", "Stormy Breakwater", "Glass Starfish"
    | "Vintage Pirate Hat",
      "Harbor Managers Office",
      "Model Ship in Large Bottle"
    | "Vintage Pirate Hat",
      "Harbor Managers Office",
      "Antique Glass Fishnet Float"
    | "Amethyst Octopus", "Stormy Breakwater", "Crystal Crab"
    | _, "Abandoned Lighthouse", "Brass Spyglass"
    -> True
    _, _, _ -> False
  }
}
