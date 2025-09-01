fn append_local(concat_list: List(a), list: List(a)) -> List(a) {
  case list {
    [head, ..tail] -> append_local([head, ..concat_list], tail)
    _ -> concat_list
  }
}

pub fn append(first first: List(a), second second: List(a)) -> List(a) {
  reverse(first) |> append_local(second) |> reverse
}

fn concat_local_lists(
  concat_list: List(a),
  list_of_lists: List(List(a)),
) -> List(a) {
  case list_of_lists {
    [head, ..tail] -> append(concat_list, head) |> concat_local_lists(tail)
    _ -> concat_list
  }
}

pub fn concat(lists: List(List(a))) -> List(a) {
  concat_local_lists([], lists)
}

pub fn filter(list: List(a), function: fn(a) -> Bool) -> List(a) {
  case list {
    [head, ..tail] -> {
      case function(head) {
        True -> [head, ..filter(tail, function)]
        False -> filter(tail, function)
      }
    }
    _ -> []
  }
}

pub fn length(list: List(a)) -> Int {
  case list {
    [_head, ..tail] -> 1 + length(tail)
    _ -> 0
  }
}

pub fn map(list: List(a), function: fn(a) -> b) -> List(b) {
  case list {
    [head, ..tail] -> [function(head), ..map(tail, function)]
    _ -> []
  }
}

pub fn foldl(
  over list: List(a),
  from initial: b,
  with function: fn(b, a) -> b,
) -> b {
  case list {
    [head, ..tail] -> foldl(tail, function(initial, head), function)
    _ -> initial
  }
}

pub fn foldr(
  over list: List(a),
  from initial: b,
  with function: fn(b, a) -> b,
) -> b {
  reverse(list) |> foldl(initial, function)
}

fn reverse_local(reversed_list: List(a), original_list: List(a)) -> List(a) {
  case original_list {
    [head, ..tail] -> reverse_local([head, ..reversed_list], tail)
    _ -> reversed_list
  }
}

pub fn reverse(list: List(a)) -> List(a) {
  reverse_local([], list)
}
