class SculptureSimulator
  def self.simulate(disks)

    Disk.set_button_multiple_for(disks)
    
    button_presses_for_all_disks = []
    button_presses_for_each_disk = disks.map { |e| [] }

    while button_presses_for_all_disks.empty?
      presses_for_zero = next_100_button_presses_for_each_disk(disks)
      presses_for_zero.each_with_index do |ps, i|
        button_presses_for_each_disk[i].concat(ps)
      end
      button_presses_for_all_disks = button_presses_for_each_disk.inject(:&)
    end

    button_presses_for_all_disks[0]
  end

  private

  def self.next_100_button_presses_for_each_disk(disks)
    disks.map do |d| 
      (0..100).map do |x|
        d.times_for_button_press.next
      end
    end
  end
end