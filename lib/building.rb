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

  def sort_by_rent
    @units.sort_by do |unit|
      unit.monthly_rent
    end
  end

  def delete_nil_renters
    remove_nil_renters = []
    sort_by_rent.each do |unit|
      if unit.renter != nil
        remove_nil_renters << unit
      end
    end
    remove_nil_renters
  end

  def renter_with_highest_rent
    delete_nil_renters[-1].renter
  end

  def units_by_number_of_bedrooms
    units_by_bedroom = @units.group_by do |unit|
      unit.bedrooms
    end
  end
end
