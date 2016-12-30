
describe "a disk" do
    describe "can step forward by multiples of its peers" do
        context "with one disk" do
            it "can step by expected multiple" do
                one = Disk.new(0, 5, 0)
                disks = [one]
                Disk.set_button_multiple_for(disks)
                #lcm of 5
                disks.each { |d| expect(d.button_multiple).to eq 5 }
                first_for_one = one.times_for_button_press.next
                expect(first_for_one).to eq 4
                #takes one second to fall
                result = one.if_capsule_arrives_at(5)
                expect(result.key? :falls_through).to eq true
            end
        end

        context "with disks that start at 0" do
            it "can calculate expected multiples" do
                one = Disk.new(0, 5, 0)
                two = Disk.new(1, 7, 0)
                three = Disk.new(2, 19, 1)
                disks = [one, two, three]
                
                Disk.set_button_multiple_for(disks)

                #lcm of 5 and 7 == 35
                disks.each { |d| expect(d.button_multiple).to eq 35 }
            end

            it "can step by expected multiples" do
                one = Disk.new(0, 5, 0)
                two = Disk.new(1, 7, 0)
                three = Disk.new(2, 19, 1)
                disks = [one, two, three]
                
                Disk.set_button_multiple_for(disks)

                first_for_one = one.times_for_button_press.next
                first_for_two = two.times_for_button_press.next
                first_for_three = three.times_for_button_press.next

                expect(first_for_one).to eq 34
                expect(first_for_two).to eq 35
                expect(first_for_three).to eq 36
            end 
        end
    end
  it "can report the first time at position 0" do
    # [0, 1, 2, 3, *4]
    disk_one = Disk.new(0, 5, 4)
    time = disk_one.times_for_button_press.next

    expect(time).to eq 0
    expect(disk_one.if_capsule_arrives_at 1).to eq falls_through: 1

    # [0, 1, *2, 3, 4, 5]
    disk_two = Disk.new(0, 6, 2)
    time = disk_two.times_for_button_press.next

    expect(time).to eq 3
    expect(disk_two.if_capsule_arrives_at 4).to eq falls_through: 4


    # [0, 1, 2, 3, *4, 5, 6, 7, 8 ,9]
    disk_three = Disk.new(0, 10, 4)
    time = disk_three.times_for_button_press.next

    expect(time).to eq 5
    expect(disk_three.if_capsule_arrives_at 6).to eq falls_through: 6
  end

  it "can report the second time at position 0" do
    # [0, 1, 2, 3, *4]
    disk_one = Disk.new(0, 5, 4)
    time = disk_one.times_for_button_press.next
    time = disk_one.times_for_button_press.next

    expect(time).to eq 5
    expect(disk_one.if_capsule_arrives_at 6).to eq falls_through: 6

    # [0, 1, *2, 3, 4, 5]
    disk_two = Disk.new(0, 6, 2)
    time = disk_two.times_for_button_press.next
    time = disk_two.times_for_button_press.next

    expect(time).to eq 9
    expect(disk_two.if_capsule_arrives_at 10).to eq falls_through: 10


    # [0, 1, 2, 3, *4, 5, 6, 7, 8 ,9]
    disk_three = Disk.new(0, 10, 4)
    time = disk_three.times_for_button_press.next
    time = disk_three.times_for_button_press.next

    expect(time).to eq 15
    expect(disk_three.if_capsule_arrives_at 16).to eq falls_through: 16
  end
end