
require_relative('./disk.rb')

class Sculpture
  def initialize(disks)
    @disks = disks
  end

  def press_button_at_time(tick)
    disk_result = nil

    @disks.each do |disk|
      tick += 1

      disk_result = disk.if_capsule_arrives_at tick
      break if disk_result.key? :bounced_away_at
    end

    disk_result
  end
end