// TODO: please define the 'Approval' custom type

// TODO: please define the 'Cuisine' custom type

// TODO: please define the 'Genre' custom type

// TODO: please define the 'Activity' custom type

pub type Approval {
  Yes
  No
  Maybe
}

pub type Cuisine {
  Turkish
  Korean
}

pub type Genre {
  Crime
  Horror
  Romance
  Thriller
}

pub type Activity {
  Movie(Genre)
  BoardGame
  Chill
  Restaurant(Cuisine)
  Walk(Int)
}

pub fn rate_activity(activity: Activity) -> Approval {
  case activity {
    Movie(genre) ->
      case genre {
        Romance -> Yes
        _ -> No
      }
    Restaurant(cuisine) ->
      case cuisine {
        Korean -> Yes
        Turkish -> Maybe
      }
    Walk(int) ->
      case int {
        int if int > 11 -> Yes
        int if int > 6 -> Maybe
        _ -> No
      }

    BoardGame | Chill | _ -> No
  }
}
