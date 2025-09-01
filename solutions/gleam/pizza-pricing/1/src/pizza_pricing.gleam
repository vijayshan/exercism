import gleam/list

pub type Pizza {
  Margherita
  Caprese
  Formaggio
  ExtraSauce(Pizza)
  ExtraToppings(Pizza)
}

pub fn pizza_price(pizza: Pizza) -> Int {
  case pizza {
    Margherita -> 7
    Caprese -> 9
    Formaggio -> 10
    ExtraSauce(x) -> 1 + pizza_price(x)
    ExtraToppings(x) -> 2 + pizza_price(x)
  }
}

fn order_price_local(order: List(Pizza), cost: Int) -> Int {
  case order {
    [head, ..tail] -> order_price_local(tail, pizza_price(head) + cost)
    _ -> cost
  }
}

pub fn order_price(order: List(Pizza)) -> Int {
  let extra_cost = case list.length(order) {
    1 -> 3
    2 -> 2
    _ -> 0
  }
  order_price_local(order, extra_cost)
}
