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
    Movie(Romance) -> Yes
    Restaurant(Korean) -> Yes
    Restaurant(Turkish) -> Maybe
    Walk(i) if i > 11 -> Yes
    Walk(i) if i > 6 -> Maybe
    _ -> No
  }
}
