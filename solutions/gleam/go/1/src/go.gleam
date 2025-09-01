import gleam/result

pub type Player {
  Black
  White
}

pub type Game {
  Game(
    white_captured_stones: Int,
    black_captured_stones: Int,
    player: Player,
    error: String,
  )
}

pub fn apply_rules(
  game: Game,
  rule1: fn(Game) -> Result(Game, String),
  rule2: fn(Game) -> Game,
  rule3: fn(Game) -> Result(Game, String),
  rule4: fn(Game) -> Result(Game, String),
) -> Game {
  case
    game
    |> rule1
    |> result.map(fn(x) { x |> rule2 })
    |> result.try(fn(x) { x |> rule3 })
    |> result.try(fn(x) { x |> rule4 })
  {
    Ok(g) ->
      Game(..g, player: {
        case g.player {
          White -> Black
          Black -> White
        }
      })
    Error(messg) -> Game(..game, error: messg)
  }
}
