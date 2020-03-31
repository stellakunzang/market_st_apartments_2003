class Building
  attr_reader :units, :rented_units

  def initialize
    @units = []
    @renters = []
    @rented_units = []
  end

  def add_unit(unit)
    @units << unit
  end

  def renters
    @units.each do |unit|
      if unit.renter != nil
        @renters << unit.renter.name
      end
    end
    @renters.uniq
  end

  def average_rent
    rents = 0.0
    count = 0
    @units.each do |unit|
      rents += unit.monthly_rent
      count += 1
    end
    rents/count
  end

  def rented_units
    @units.each do |unit|
      if unit.renter != nil
        @rented_units << unit
      end
    end
    @rented_units
  end

  def renter_with_highest_rent

  end


end
