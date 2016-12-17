
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

  def not_set(a, b)
    a==nil && b==nil
  end

  def earlier_is_smaller(a, b)
    a < b
  end

  def candidates_are_valid(candidates)
    candidates.each_cons(2).all? { |a, b| a[:next] + 1 == b[:next] }
  end

  def ensure_sorted_ascending(candidates)
    p "start comparison!"

    candidates = candidates.each_cons(2).to_a.map do |a,b| 
      new_candidate = [a, b]
      p "comparing two disk candidates #{new_candidate.map { |e| e[:next] }}" 

      if a[:next] < b[:next] then
        p "left less than right"
        new_candidate = [
          {disk: a[:disk], next: a[:disk].times_for_position_0.next },
          b
        ]
        p new_candidate.map { |e| e[:next] }
      elsif a[:next] + 1 == b[:next]
        # do nothing
      else
        p "either equal to or more than one greater than right"
        new_candidate = [
          a,
          {disk: b[:disk], next: b[:disk].times_for_position_0.next }
        ]
        p new_candidate.map { |e| e[:next] }
      end

      new_candidate
    end

    candidates.flatten
  end

  def find_time_to_press_button
    disks = @disks.map { |d| d.clone }

    candidates = nil

    candidates_are_valid = false

    until candidates_are_valid
      p "loop!"
      p "candidates are #{(candidates || []).map { |e| e[:next] }}"

      if candidates == nil
        candidates = disks.map { |d| {disk: d, next: d.times_for_position_0.next} }
        p "init candidates #{candidates.map { |e| e[:next] }}"
      elsif candidates_are_valid(candidates)
        p "valid! #{candidates.map { |e| e[:next] }}"
        candidates_are_valid = true
      else
        candidates = ensure_sorted_ascending(candidates)
      end
    end

    p "candidates finish as #{candidates.map { |e| e[:next] }}"

    candidates[0][:next] - 1
  end
end