import gleam/int
import gleam/list

pub type Command {
  Wink
  DoubleBlink
  CloseYourEyes
  Jump
}

pub fn commands(encoded_message: Int) -> List(Command) {
  let dict_list = [Wink, DoubleBlink, CloseYourEyes, Jump]

  list.index_fold(dict_list, [], fn(acc, item, index) {
    case check_bit(encoded_message, index) {
      0 -> acc
      _ -> list.append(acc, [item])
    }
  })
  |> fn(list_of_commands) {
    case check_bit(encoded_message, 4) {
      0 -> list_of_commands
      _ -> list.reverse(list_of_commands)
    }
  }
}

fn check_bit(encoded_message, bit_pos) {
  int.bitwise_and(encoded_message, int.bitwise_shift_left(1, bit_pos))
}
