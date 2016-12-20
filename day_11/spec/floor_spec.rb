require_relative('../floor.rb')
require_relative('../elevator.rb')
require_relative('../item.rb')

describe "a floor" do
    xit "can be empty" do
      expect(Floor.new(1).items.length).to eq 0
    end

    xit "returns a new floor when leaving items behind" do
      item = Microchip.new(:hydrogen)
      elevator = Elevator.new(item)
      a = Floor.new(0, elevator)

      expect(a.items).to be_empty
      expect(a.elevator.items).not_to be_empty

      floor = a.unload(item)

      # original unmodified
      expect(a.items).to be_empty
      expect(a.elevator.items).not_to be_empty
      # new correct
      expect(floor.items).not_to be_empty
      expect(floor.elevator.items).to be_empty
    end

    xit "can load an item into the elevator" do
      elevator = Elevator.new
      item = Microchip.new(:hydrogen)
      a = Floor.new(0, elevator, item)

      expect(a.items).not_to be_empty
      expect(a.elevator.items).to be_empty

      floor = a.load(item)

      # original unmodified
      expect(a.items).not_to be_empty
      expect(a.elevator.items).to be_empty

      # new correct
      expect(floor.items).to be_empty
      expect(floor.elevator.items).not_to be_empty
    end

    xit "can load two items onto the elevator" do
      elevator = Elevator.new
      item_a = Microchip.new(:hydrogen)
      item_b = Microchip.new(:lithium)
      a = Floor.new(0, elevator, [item_a, item_b])
      a = a.load(item_a)
      a = a.load(item_b)
      expect(a.elevator.items.length).to eq 2
    end

    describe "can be valid" do
      xit "with a matching microchip and generator" do
        f = Floor.new(0, nil, [Microchip.new(:hydrogen), Generator.new(:hydrogen)])
        expect(f.is_valid?).to be true
      end

      xit "with just a microchip" do
        floor = Floor.new(0, nil, Microchip.new(:hydrogen))
        expect(floor.is_valid?).to be true
      end

      xit "with just a generator" do
        floor = Floor.new(0, nil, Generator.new(:hydrogen))
        expect(floor.is_valid?).to be true
      end

      xit "with 2 microchips" do
        floor = Floor.new(0, nil, [Microchip.new(:hydrogen), Microchip.new(:water)])
        expect(floor.is_valid?).to be true
      end

      xit "with 2 generators" do
        floor = Floor.new(0, nil, [Generator.new(:hydrogen), Generator.new(:water)])
        expect(floor.is_valid?).to be true
      end
    end

    describe "can be invalid" do
      xit "with a mismatched microchip and generator" do
        floor = Floor.new(0, nil, [Microchip.new(:hydrogen), Generator.new(:lithium)])
        expect(floor.is_valid?).to be false
      end
    end

    describe "with an elevator" do
      xit "can be valid" do
        elevator = Elevator.new(Microchip.new(:lithium))
        floor = Floor.new(0, elevator, Generator.new(:lithium))
        expect(floor.is_valid?).to be true
      end

      xit "can be invalid" do
        elevator = Elevator.new(Microchip.new(:lithium))
        floor = Floor.new(0, elevator, Generator.new(:tritium))
        expect(floor.is_valid?).to be false
      end
    end
  end