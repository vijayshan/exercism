import gleam/list

pub type Nucleotide {
  Adenine
  Cytosine
  Guanine
  Thymine
}

pub fn encode_nucleotide(nucleotide: Nucleotide) -> Int {
  case nucleotide {
    Adenine -> 0
    Cytosine -> 1
    Guanine -> 2
    Thymine -> 3
  }
}

pub fn decode_nucleotide(nucleotide: Int) -> Result(Nucleotide, Nil) {
  case nucleotide {
    0 -> Ok(Adenine)
    1 -> Ok(Cytosine)
    2 -> Ok(Guanine)
    3 -> Ok(Thymine)
    _ -> Error(Nil)
  }
}

pub fn encode(dna: List(Nucleotide)) -> BitArray {
  case dna {
    [h, ..t] -> <<encode_nucleotide(h):size(2), encode(t):bits>>
    _ -> <<>>
  }
}

fn bit_array_to_list(b: BitArray) -> List(Int) {
  case b {
    <<item:2, remaining:bits>> -> [item, ..bit_array_to_list(remaining)]
    <<>> -> []
    _ -> [-1]
  }
}

pub fn decode(dna: BitArray) -> Result(List(Nucleotide), Nil) {
  dna |> bit_array_to_list |> list.try_map(decode_nucleotide)
}
