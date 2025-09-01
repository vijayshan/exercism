// Please define the GbTree type
// import 
pub type GbTree(k, v)

@external(erlang, "gb_trees", "empty")
pub fn new_gb_tree() -> GbTree(k, v)

@external(erlang, "gb_trees", "insert")
fn insert_er(key: k, value: v, tree: GbTree(k, v)) -> GbTree(k, v)

@external(erlang, "gb_trees", "delete_any")
fn delete_er(key: k, tree: GbTree(k, v)) -> GbTree(k, v)

pub fn insert(tree: GbTree(k, v), key: k, value: v) -> GbTree(k, v) {
  insert_er(key, value, tree)
}

pub fn delete(tree: GbTree(k, v), key: k) -> GbTree(k, v) {
  delete_er(key, tree)
}
