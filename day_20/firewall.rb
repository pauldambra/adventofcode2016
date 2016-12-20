class Firewall
  def initialize(max)
    @max = max
  end

  def lowest_allowed_ip(ranges)
    ranges = parse_ranges(ranges)
    
    lowest_ip = 0

    ranges.each do |r| 
      lowest_ip = check_counter_against_range(lowest_ip, r)
    end
    
    lowest_ip
  end

  def allowed_ips(ranges)
    ranges = parse_ranges(ranges)
    
    allowed_ips = []
    current_ip = 0
    
    ranges.each do |r|
      if current_ip < r[0]
        allowed_ips.push(current_ip..(r[0]-1)) 
        current_ip = r[1] + 1
      else
        current_ip = check_counter_against_range(current_ip, r)
      end
    end

    allowed_ips.map(&:to_a).flatten
  end

  def check_counter_against_range(counter, r)
    if r[0] <= counter && counter <= r[1]
      r[1] + 1
    else
      counter
    end
  end

  def parse_ranges(ranges)
    ranges
      .map(&:chomp)
      .map { |e| e.split('-') }
      .map { |e| [e[0].to_i, e[1].to_i] }
      .sort_by { |e| e[0] }
  end
end