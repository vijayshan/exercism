defmodule SpaceAge do
  @type planet ::
          :mercury
          | :venus
          | :earth
          | :mars
          | :jupiter
          | :saturn
          | :uranus
          | :neptune

  @doc """
  Return the number of years a person that has lived for 'seconds' seconds is
  aged on 'planet'.
  """
  @spec age_on(planet, pos_integer) :: float
  def age_on(planet, seconds) do
    earth_years = seconds / 60 / 60 / 24 / 365.25

    case planet do
      :mercury ->
        year_calc(0.2408467, earth_years)

      :venus ->
        year_calc(0.61519726, earth_years)

      :earth ->
        earth_years

      :mars ->
        year_calc(1.8808158, earth_years)

      :jupiter ->
        year_calc(11.862615, earth_years)

      :saturn ->
        year_calc(29.447498, earth_years)

      :uranus ->
        year_calc(84.016846, earth_years)

      :neptune ->
        year_calc(164.79132, earth_years)
    end
  end

  # helper function  to convert earth years to
  # years on a particular planet by dividing with the
  # factor provided

  defp year_calc(div, earth_years) do
    earth_years / div
  end
end
