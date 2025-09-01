import gleam/int

pub fn is_leap_year(year: Int) -> Bool {
  case int.modulo(year, 4) {
    Ok(0) ->
      case int.modulo(year, 100) {
        Ok(0) ->
          case int.modulo(year, 400) {
            Ok(0) -> True
            _ -> False
          }
        _ -> True
      }
    _ -> False
  }
}
