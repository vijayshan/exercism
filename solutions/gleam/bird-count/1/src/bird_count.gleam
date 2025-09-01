import gleam/list

pub fn today(days: List(Int)) -> Int {
  case list.first(days) {
    Ok(num) -> num
    _ -> 0
  }
}

pub fn increment_day_count(days: List(Int)) -> List(Int) {
  case days {
    [] -> [1]
    [head, ..tail] -> [head + 1, ..tail]
  }
}

pub fn has_day_without_birds(days: List(Int)) -> Bool {
  case days {
    [] -> False
    [head, ..tail] -> {
      case head {
        0 -> True
        _ -> has_day_without_birds(tail)
      }
    }
  }
}

pub fn total(days: List(Int)) -> Int {
  case days {
    [] -> 0
    [head, ..tail] -> head + total(tail)
  }
}

pub fn busy_days(days: List(Int)) -> Int {
  case days {
    [] -> 0
    [head, ..tail] -> {
      case head {
        _ if head >= 5 -> 1 + busy_days(tail)
        _ -> busy_days(tail)
      }
    }
  }
}
