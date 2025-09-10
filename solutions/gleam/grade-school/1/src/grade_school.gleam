import gleam/dict.{type Dict}
import gleam/list
import gleam/result
import gleam/string

pub type School {
  School(grades: Dict(Int, List(String)))
}

pub fn create() -> School {
  School(dict.new())
}

pub fn roster(school: School) -> List(String) {
  school.grades |> dict.values |> list.flatten
}

pub fn add(
  to school: School,
  student student: String,
  grade grade: Int,
) -> Result(School, Nil) {
  case roster(school) |> list.contains(student) {
    True -> Error(Nil)
    False ->
      [
        #(
          grade,
          list.append([student], grade_(school, grade))
            |> list.sort(string.compare),
        ),
      ]
      |> dict.from_list
      |> dict.merge(school.grades, _)
      |> School()
      |> Ok
  }
}

pub fn grade(school: School, desired_grade: Int) -> List(String) {
  grade_(school, desired_grade)
}

fn grade_(school: School, desired_grade: Int) -> List(String) {
  school.grades
  |> dict.get(desired_grade)
  |> result.unwrap([])
}
