import gleam/list
import gleam/string

pub type Student {
  Alice
  Bob
  Charlie
  David
  Eve
  Fred
  Ginny
  Harriet
  Ileana
  Joseph
  Kincaid
  Larry
}

pub type Plant {
  Radishes
  Clover
  Violets
  Grass
}

pub fn plants(diagram: String, student: Student) -> List(Plant) {
  let location = { student |> student_order } - 1
  diagram
  |> string.split("\n")
  |> list.map(string.to_graphemes)
  |> list.map(fn(x) { list.sized_chunk(x, 2) })
  |> list.map(fn(x) {
    list.index_fold(x, [], fn(acc, item, index) {
      case index == location {
        True -> item
        False -> acc
      }
    })
  })
  |> list.flatten
  |> list.map(string_to_plant)
}

fn student_order(student: Student) -> Int {
  case student {
    Alice -> 1
    Bob -> 2
    Charlie -> 3
    David -> 4
    Eve -> 5
    Fred -> 6
    Ginny -> 7
    Harriet -> 8
    Ileana -> 9
    Joseph -> 10
    Kincaid -> 11
    Larry -> 12
  }
}

fn string_to_plant(s: String) -> Plant {
  case s {
    "R" -> Radishes
    "C" -> Clover
    "V" -> Violets
    "G" -> Grass
    _ -> Radishes
  }
}
