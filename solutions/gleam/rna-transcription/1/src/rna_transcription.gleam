import gleam/list
import gleam/result
import gleam/string

pub fn to_rna(dna: String) -> Result(String, Nil) {
  dna
  |> string.split("")
  |> list.try_map(fn(x) {
    case x {
      "G" -> Ok("C")
      "C" -> Ok("G")
      "T" -> Ok("A")
      "A" -> Ok("U")
      _ -> Error(Nil)
    }
  })
  |> result.try(fn(x) { Ok(string.join(x, "")) })
}
