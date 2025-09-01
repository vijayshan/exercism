import gleam/int
import gleam/option.{type Option, None, Some}

pub type Player {
  Player(name: Option(String), level: Int, health: Int, mana: Option(Int))
}

pub fn introduce(player: Player) -> String {
  case player.name {
    Some(name) -> name
    None -> "Mighty Magician"
  }
}

pub fn revive(player: Player) -> Option(Player) {
  case player {
    Player(_, level, health, _) if health <= 0 && level < 10 ->
      Some(Player(..player, health: 100))
    Player(_, _, health, _) if health <= 0 ->
      Some(Player(..player, health: 100, mana: Some(100)))
    _ -> None
  }
}

pub fn cast_spell(player: Player, cost: Int) -> #(Player, Int) {
  case player {
    Player(_, _, health, Some(mana)) if health > 0 && mana > cost -> #(
      Player(..player, mana: Some(mana - cost)),
      cost * 2,
    )
    Player(_, _, health, None) if health > 0 -> #(
      Player(..player, health: int.max(player.health - cost, 0)),
      0,
    )
    _ -> #(player, 0)
  }
}
