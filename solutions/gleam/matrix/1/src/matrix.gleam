import gleam/int
import gleam/list
import gleam/result
import gleam/string

pub fn row(index: Int, string: String) -> Result(List(Int), Nil) {
  case string |> into_the_matrix_ {
    Ok(matrix) -> matrix |> extract_item_(index)
    Error(_) -> Error(Nil)
  }
}

pub fn column(index: Int, string: String) -> Result(List(Int), Nil) {
  case string |> into_the_matrix_ {
    Ok(matrix) -> matrix |> list.transpose |> extract_item_(index)
    Error(_) -> Error(Nil)
  }
}

//private functions 
fn extract_item_(matrix: List(List(Int)), index) {
  case matrix |> list.length >= index {
    True -> matrix |> at_(index - 1) |> Ok
    False -> Error(Nil)
  }
}

fn into_the_matrix_(str: String) -> Result(List(List(Int)), Nil) {
  str
  |> string.split("\n")
  |> list.map(fn(x) {
    string.split(x, " ") |> list.map(int.parse) |> result.all
  })
  |> result.all
}

fn at_(lis: List(List(Int)), index: Int) -> List(Int) {
  lis
  |> list.index_fold([], fn(acc, item, i) {
    case i == index {
      True -> item
      False -> acc
    }
  })
}
