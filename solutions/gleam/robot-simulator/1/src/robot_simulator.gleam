import gleam/string

pub type Robot {
  Robot(direction: Direction, position: Position)
}

pub type Direction {
  North
  East
  South
  West
}

pub type Position {
  Position(x: Int, y: Int)
}

pub fn create(direction: Direction, position: Position) -> Robot {
  Robot(direction, position)
}

pub fn move(
  direction: Direction,
  position: Position,
  instructions: String,
) -> Robot {
  move_(direction, position, string.split(instructions, ""))
}

fn move_(direction: Direction, position: Position, instructions: List(String)) {
  case instructions {
    ["R", ..l] -> move_(direction |> turn_right, position, l)
    ["L", ..l] -> move_(direction |> turn_left, position, l)
    ["A", ..l] -> move_(direction, advance(position, direction), l)
    [_, ..l] -> move_(direction, position, l)
    [] -> create(direction, position)
  }
}

fn turn_right(direction: Direction) -> Direction {
  case direction {
    North -> East
    East -> South
    South -> West
    West -> North
  }
}

fn turn_left(direction: Direction) -> Direction {
  case direction {
    North -> West
    West -> South
    South -> East
    East -> North
  }
}

fn advance(position: Position, direction: Direction) -> Position {
  case position, direction {
    Position(x, y), North -> Position(x, y + 1)
    Position(x, y), East -> Position(x + 1, y)
    Position(x, y), South -> Position(x, y - 1)
    Position(x, y), West -> Position(x - 1, y)
  }
}
