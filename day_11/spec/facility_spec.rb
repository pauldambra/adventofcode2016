require_relative('../floor.rb')
require_relative('../item.rb')
require_relative('../elevator.rb')
require_relative('../radioisotope_testing_facility.rb')

describe "a facility" do

  it "returns a new object when an elevator changes floor" do
    elevator = Elevator.new(Microchip.new(:biscuits))
    floor_one = Floor.new(0, elevator)
    floor_two = Floor.new(1)
    a = RadioisotopeTestingFacility.new([floor_one, floor_two])
    b = a.elevator_goes :up
    expect(b).to be_a RadioisotopeTestingFacility
    expect(a).not_to be b

    expect(a.show).to eq "F1  \nF0 E BM"
    expect(b.show).to eq "F1 E BM\nF0  "
  end

  describe "can be valid" do
    it "when a floor has matched generator and microchip" do
      floor = Floor.new(0, nil, [Microchip.new(:hydrogen), Generator.new(:hydrogen)])
      facility = RadioisotopeTestingFacility.new(floor)
      expect(facility.is_valid?).to be true
    end

    it "when one floor has a generator and another a microchip" do
      floor_one = Floor.new(0, nil, Microchip.new(:hydrogen))

      floor_two = Floor.new(1, nil, Generator.new(:lithium))

      facility = RadioisotopeTestingFacility.new([floor_one, floor_two])
      expect(facility.is_valid?).to be true
    end
  end

  describe "can be invalid" do
    it "when a floor has an unmatched generator and microchip when elevator unloads"  do
      elevator = Elevator.new
      elevator = elevator.load(Microchip.new(:lithium))

      floor = Floor.new(0, elevator, [Microchip.new(:hydrogen), Generator.new(:hydrogen), Generator.new(:lithium)])

      facility = RadioisotopeTestingFacility.new([floor, Floor.new(1)])

      expect(facility.is_valid?).to be true

      facility = facility.elevator_goes :up

      expect(facility.is_valid?).to be false
    end

    it "when a floor has an unmatched generator and microchip when elevator arrives" do
      elevator = Elevator.new
      elevator = elevator.load(Microchip.new(:hydrogen))

      floor = Floor.new(0, elevator, [Generator.new(:hydrogen)])
      
      floor_two = Floor.new(1, nil, Generator.new(:tritium))

      facility = RadioisotopeTestingFacility.new([floor, floor_two])

      expect(facility.is_valid?).to be true

      facility = facility.elevator_goes :up

      expect(facility.is_valid?).to be false
    end

    # An RTG powering a microchip is still dangerous to other microchips.
    it "when a floor has a solo chip and matched generator and microchip" do
      elevator = Elevator.new
      chip_a = Microchip.new(:uranium)
      gen_a = Generator.new(:uranium)
      chip_b = Microchip.new(:titanium)
      gen_b = Generator.new(:titanium)
      one = Floor.new(0, elevator, [chip_a, gen_a, chip_b, gen_b])
      two = Floor.new(1)
      facility = RadioisotopeTestingFacility.new([one, two])

      expect(facility.is_valid?).to be true

      facility = facility.load_item_from_floor_to_elevator(gen_a, 0)
      facility = facility.elevator_goes :up

      expect(facility.is_valid?).to be false
    end

  end
end