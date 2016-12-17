
describe "a disk" do
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