class SculptureSimulator

  def self.simulate_at_tick(disks, tick)
    disks = disks.map { |d| create(d) }

    for i in (1..tick+disks.length)
      disks.each { |d| d.rotate! }

      next unless i > tick
      
      disks.each.with_index do |disk, index|
        disk_time = tick + (index + 1)
        next unless i == disk_time
        
        unless disk[0] == 0
          raise "pressing the button at tick #{i} fails at disk #{index}"
        end
      end
    end
  end

  #each disk is a hash of number of positions and starting position
  def self.simulate(disks)
    
    disks = disks.map { |d| create(d) }

    ticks = 0
    loop do
      step = lcm_of_aligned_disks(disks) || 1

      disks.each do |disk|
        disk_rotatations!(disk, step)
      end
      ticks += step

      break if disks_are_aligned?(disks)
    end

    ticks - 1
  end

  # if stepping many times more than the length of the disk
  # we can use step modulo disk length to figure out
  # what index the disk would end at and never have to rotate
  # the disk more than it's own length number of times
  def self.disk_rotatations!(disk, step)
    n = step
    if step > disk.length
      n = step % disk.length
    end
    (1..n).each { |_| disk.rotate! }
  end

  def self.lcm_of_aligned_disks(disks)
    aligned_disks = disks.each.with_index.reduce([]) do |agg, (disk, index)| 
      agg.push(disk) if disk_is_aligned?(disk, index)
      agg
    end
    aligned_disks.map { |d| d.length }
                 .reduce(:lcm)
  end

  def self.disks_are_aligned?(disks)
    disks.map.with_index { |d, i| disk_is_aligned?(d, i) }
              .all? { |pc| pc == true }
  end

  def self.disk_is_aligned?(disk, index)
    target_index = index
    if target_index > disk.length
      target_index = index % disk.length
    end
    actual_index = disk.index(0)
    actual_index == target_index
  end

  def self.create(d)
    positions = *(0..d[:number_of_positions] - 1)
    positions.rotate(d[:starting_position])
  end
end