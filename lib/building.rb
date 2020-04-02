class Building
  attr_reader :units, :rented_units

  def initialize
    @units = []
  end

  def add_unit(unit)
    @units << unit
  end

  def renters
    renters = []
    @units.each do |unit|
      if unit.renter != nil
        renters << unit.renter.name
      end
    end
    renters
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
    rented_units = []
    @units.each do |unit|
      if unit.renter != nil
        rented_units << unit
      end
    end
    rented_units
  end

  def sort_by_rent
    @units.sort_by do |unit|
      unit.monthly_rent
    end
  end

  def units_with_renters
    remove_nil_renters = []
    sort_by_rent.each do |unit|
      if unit.renter != nil
        remove_nil_renters << unit
      end
    end
    remove_nil_renters
  end

  def renter_with_highest_rent
    units_with_renters[-1].renter
  end

  # def units_by_number_of_bedrooms
  #   units_by_bedroom = @units.group_by do |unit|
  #     unit.bedrooms
  #   end
  # end
  #
  def units_by_number_of_bedrooms
    units_by_num_bed = {}
    @units.each do |unit|
      if units_by_num_bed[unit.bedrooms] == nil
        units_by_num_bed[unit.bedrooms] = [unit.number]
      else
        units_by_num_bed[unit.bedrooms] << unit.number
      end
    end
    units_by_num_bed
  end

  def annual_breakdown
    breakdown = {}
    units_with_renters.each do |unit|
      breakdown[unit.renter.name] = (unit.monthly_rent * 12)
    end
    breakdown
  end

  def rooms_by_renter
    rooms = {}
    units_with_renters.reverse.each do |unit|
      rooms[unit.renter] = {bathrooms: unit.bathrooms, bedrooms: unit.bedrooms}
    end
    rooms
  end
end
