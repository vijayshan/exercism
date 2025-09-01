import gleam/list

pub fn today(days: List(Int)) -> Int {
  case list.first(days) {
    Ok(num) -> num
    _ -> 0
  }
}

pub fn increment_day_count(days: List(Int)) -> List(Int) {
  case days {
    [head, ..tail] -> [head + 1, ..tail]
    _ -> [1]
  }
}

pub fn has_day_without_birds(days: List(Int)) -> Bool {
  case days {
    [head, ..tail] -> {
      case head {
        0 -> True
        _ -> has_day_without_birds(tail)
      }
    }
    _ -> False
  }
}

pub fn total(days: List(Int)) -> Int {
  case days {
    [head, ..tail] -> head + total(tail)
    _ -> 0
  }
}

pub fn busy_days(days: List(Int)) -> Int {
  case days {
    [head, ..tail] -> {
      case head {
        _ if head >= 5 -> 1 + busy_days(tail)
        _ -> busy_days(tail)
      }
    }
    _ -> 0
  }
}
