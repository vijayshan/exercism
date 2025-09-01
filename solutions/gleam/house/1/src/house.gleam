import gleam/list
import gleam/result

pub fn recite(start_verse start_verse: Int, end_verse end_verse: Int) -> String {
  list.range(start_verse, end_verse)
  |> list.map(verse_builder("This is ", _))
  |> list.reduce(fn(acc, x) { acc <> "\n" <> x })
  |> result.unwrap("")
}

fn verse_builder(acc: String, num: Int) -> String {
  case num > 0 && num < 13 {
    True -> verse_builder(acc <> verse_map(num), num - 1)
    False -> acc
  }
}

fn verse_map(num: Int) -> String {
  case num {
    1 -> "the house that Jack built."
    2 -> "the malt that lay in "
    3 -> "the rat that ate "
    4 -> "the cat that killed "
    5 -> "the dog that worried "
    6 -> "the cow with the crumpled horn that tossed "
    7 -> "the maiden all forlorn that milked "
    8 -> "the man all tattered and torn that kissed "
    9 -> "the priest all shaven and shorn that married "
    10 -> "the rooster that crowed in the morn that woke "
    11 -> "the farmer sowing his corn that kept "
    12 -> "the horse and the hound and the horn that belonged to "
    _ -> ""
  }
}
