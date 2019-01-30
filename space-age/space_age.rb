class SpaceAge

  ORBITAL_PERIOD = {
    :Earth => 1,
    :Mercury => 0.2408467,
    :Venus => 0.61519726,
    :Mars => 1.8808158,
    :Jupiter => 11.862615,
    :Saturn => 29.447498,
    :Uranus => 84.016846,
    :Neptune => 164.79132
  }
  SECONDS_IN_YEAR = 31557600

  attr_reader :seconds

  def initialize(seconds)
    @seconds = seconds
  end

  def on_earth
    age(:Earth)
  end

  def on_mercury
    age(:Mercury)
  end

  def on_venus
    age(:Venus)
  end

  def on_mars
    age(:Mars)
  end

  def on_jupiter
    age(:Jupiter)
  end

  def on_saturn
    age(:Saturn)
  end

  def on_jupiter
    age(:Jupiter)
  end

  def on_uranus
    age(:Uranus)
  end

  def on_neptune
    age(:Neptune)
  end

  private

  def days_to_seconds(years)
    years * SpaceAge::SECONDS_IN_YEAR
  end

  def age(planet)
    seconds/days_to_seconds(SpaceAge::ORBITAL_PERIOD[planet]).to_f
  end

end
