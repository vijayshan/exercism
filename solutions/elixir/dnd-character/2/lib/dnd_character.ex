defmodule DndCharacter do
  @type t :: %__MODULE__{
          strength: pos_integer(),
          dexterity: pos_integer(),
          constitution: pos_integer(),
          intelligence: pos_integer(),
          wisdom: pos_integer(),
          charisma: pos_integer(),
          hitpoints: pos_integer()
        }

  defstruct [:strength, :dexterity, :constitution, :intelligence, :wisdom, :charisma, :hitpoints]

  @spec modifier(pos_integer()) :: integer()
  def modifier(score) do
    floor((score - 10) / 2)
  end

  @spec ability :: pos_integer()
  def ability do
    for(_n <- 1..4, do: dice_roll())
    |> Enum.sort()
    |> Enum.slice(1..3)
    |> Enum.reduce(fn x, acc -> acc + x end)
  end

  @spec character :: t()
  def character do
    ret_character = %DndCharacter{
      strength: ability(),
      dexterity: ability(),
      constitution: ability(),
      intelligence: ability(),
      wisdom: ability(),
      charisma: ability()
    }

    %{ret_character | hitpoints: modifier(ret_character.constitution) + 10}
  end

  defp dice_roll do
    :rand.uniform(6)
  end
end
