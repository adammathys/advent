module Fuel
  class << self
    def amount_required(mass)
      (mass / 3) - 2
    end

    def recursive_required(mass)
      fuel_mass = amount_required(mass)
      return 0 if fuel_mass <= 0

      fuel_mass + recursive_required(fuel_mass)
    end
  end
end
