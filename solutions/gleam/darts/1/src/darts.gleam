pub fn score(x: Float, y: Float) -> Int {
  case x *. x +. y *. y {
    v if v <=. 1.0 -> 10
    v if v <=. 25.0 -> 5
    v if v <=. 100.0 -> 1
    _ -> 0
  }
}
