require 'minitest/autorun'
require 'minitest/pride'
require './lib/renter'
require './lib/apartment'
require './lib/building'
require 'pry'

class BuildingTest < Minitest::Test
  def test_it_exists
    building = Building.new

    assert_instance_of Building, building
  end

  def test_it_has_attributes
    building = Building.new

    assert_equal [], building.units
    assert_equal [], building.renters
  end

  def test_it_can_add_units
    building = Building.new
    unit1 = Apartment.new({number: "A1", monthly_rent: 1200, bathrooms: 1, bedrooms: 1})
    unit2 = Apartment.new({number: "B2", monthly_rent: 999, bathrooms: 2, bedrooms: 2})
    building.add_unit(unit1)
    building.add_unit(unit2)

     assert_equal [unit1, unit2], building.units
  end

  def test_it_can_add_renters
    building = Building.new
    unit1 = Apartment.new({number: "A1", monthly_rent: 1200, bathrooms: 1, bedrooms: 1})
    unit2 = Apartment.new({number: "B2", monthly_rent: 999, bathrooms: 2, bedrooms: 2})
    building.add_unit(unit1)
    building.add_unit(unit2)
    assert_equal [], building.renters

    renter1 = Renter.new("Aurora")
    unit1.add_renter(renter1)
    assert_equal ["Aurora"], building.renters

    renter2 = Renter.new("Tim")
    unit2.add_renter(renter2)

    assert_equal ["Aurora", "Tim"], building.renters
  end

  def test_it_can_average_rent
    building = Building.new
    unit1 = Apartment.new({number: "A1", monthly_rent: 1200, bathrooms: 1, bedrooms: 1})
    unit2 = Apartment.new({number: "B2", monthly_rent: 999, bathrooms: 2, bedrooms: 2})
    building.add_unit(unit1)
    building.add_unit(unit2)

    assert_equal 1099.5, building.average_rent
  end

  def test_it_can_find_rented_units
    building = Building.new
    unit1 = Apartment.new({number: "A1", monthly_rent: 1200, bathrooms: 1, bedrooms: 1})
    unit2 = Apartment.new({number: "B2", monthly_rent: 999, bathrooms: 1, bedrooms: 2})
    unit3 = Apartment.new({number: "C3", monthly_rent: 1150, bathrooms: 2, bedrooms: 2})
    unit4 = Apartment.new({number: "D4", monthly_rent: 1500, bathrooms: 2, bedrooms: 3})
    renter1 = Renter.new("Spencer")
    building.add_unit(unit1)
    building.add_unit(unit2)
    building.add_unit(unit3)

    assert_equal [], building.rented_units

    unit2.add_renter(renter1)

    assert_equal [unit2], building.rented_units
  end

  def test_it_can_find_renter_with_highest_rent
    building = Building.new
    unit1 = Apartment.new({number: "A1", monthly_rent: 1200, bathrooms: 1, bedrooms: 1})
    unit2 = Apartment.new({number: "B2", monthly_rent: 999, bathrooms: 1, bedrooms: 2})
    unit3 = Apartment.new({number: "C3", monthly_rent: 1150, bathrooms: 2, bedrooms: 2})
    unit4 = Apartment.new({number: "D4", monthly_rent: 1500, bathrooms: 2, bedrooms: 3})
    renter1 = Renter.new("Spencer")
    building.add_unit(unit1)
    building.add_unit(unit2)
    building.add_unit(unit3)
    unit2.add_renter(renter1)

    assert_equal renter1, building.renter_with_highest_rent

    renter2 = Renter.new("Jessie")
    unit1.add_renter(renter2)

    assert_equal renter2,  building.renter_with_highest_rent

    renter3 = Renter.new("Max")
  end
end

# pry(main)> building.renter_with_highest_rent
# # => #<Renter:0x00007fa83bc37978...>
#
# pry(main)> renter2 = Renter.new("Jessie")
# # => #<Renter:0x00007fa83b9b0358...>
#
# pry(main)> unit1.add_renter(renter2)
#
# pry(main)> building.renter_with_highest_rent
# # => #<Renter:0x00007fa83b9b0358...>
#
# pry(main)> renter3 = Renter.new("Max")
# # => #<Renter:0x00007fa83b7t0456...>
#
# pry(main)> unit3.add_renter(renter3)
#
# pry(main)> building.renter_with_highest_rent
# # => #<Renter:0x00007fa83b9b0358...>
#
# pry(main)> building.add_unit(unit4)
#
# pry(main)> building.units_by_number_of_bedrooms
# # =>
# # {
# #   3 => ["D4" ],
# #   2 => ["B2", "C3"],
# #   1 => ["A1"]
# # }
