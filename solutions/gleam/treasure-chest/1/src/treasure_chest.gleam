pub type TreasureChest(item) {
  TreasureChest(password: String, item: item)
}

pub type UnlockResult(item) {
  Unlocked(item)
  WrongPassword
}

pub fn get_treasure(
  chest: TreasureChest(treasure),
  password: String,
) -> UnlockResult(treasure) {
  case chest {
    chest if chest.password == password -> Unlocked(chest.item)
    _ -> WrongPassword
  }
}
