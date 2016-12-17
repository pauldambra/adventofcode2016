
describe "a disk" do
  xit "can report the first time at position 0" do
    # [0, 1, 2, 3, *4]
    disk_one = Disk.new(5, 4)
    time = disk_one.times_for_position_0.next

    expect(time).to eq 1
    expect(disk_one.if_capsule_arrives_at time).to eq falls_through: 1

    # [0, 1, *2, 3, 4, 5]
    disk_two = Disk.new(6, 2)
    time = disk_two.times_for_position_0.next

    expect(time).to eq 4
    expect(disk_two.if_capsule_arrives_at time).to eq falls_through: 4


    # [0, 1, 2, 3, *4, 5, 6, 7, 8 ,9]
    disk_three = Disk.new(10, 4)
    time = disk_three.times_for_position_0.next

    expect(time).to eq 6
    expect(disk_three.if_capsule_arrives_at time).to eq falls_through: 6
  end

  xit "can report the second time at position 0" do
    # [0, 1, 2, 3, *4]
    disk_one = Disk.new(5, 4)
    time = disk_one.times_for_position_0.next
    time = disk_one.times_for_position_0.next

    expect(time).to eq 6
    expect(disk_one.if_capsule_arrives_at time).to eq falls_through: 6

    # [0, 1, *2, 3, 4, 5]
    disk_two = Disk.new(6, 2)
    time = disk_two.times_for_position_0.next
    time = disk_two.times_for_position_0.next

    expect(time).to eq 10
    expect(disk_two.if_capsule_arrives_at time).to eq falls_through: 10


    # [0, 1, 2, 3, *4, 5, 6, 7, 8 ,9]
    disk_three = Disk.new(10, 4)
    time = disk_three.times_for_position_0.next
    time = disk_three.times_for_position_0.next

    expect(time).to eq 16
    expect(disk_three.if_capsule_arrives_at time).to eq falls_through: 16
  end
end