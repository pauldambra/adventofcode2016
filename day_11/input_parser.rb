require_relative('./radioisotope_testing_facility.rb')

class InputParser
  def self.parse(input)
    input
      .lines
      .map(&:chomp)
      .reject(&:empty?)
      .map { |e| e.split(' contains ') }
      .map.with_index { |e, i| [i + 1, e[1].split('and a')] }
      .map { |e| [Floor.new(e[0]), e[1]] }
      .map { |e| [e[0], e[1].map { |i| parse_microchips(i) }]}
      .map { |e| [e[0], e[1].map { |i| parse_generators(i) }]}
      .map do |e|
        e[1].each { |i| e[0].leave i if !i.is_a? String }
        e[0]
      end

      RadioisotopeTestingFacility.new(input[0], input[1], input[2], input[3])
  end

  private

  def self.parse_microchips(i)
    return i unless i.is_a? String
    return i unless i.include? 'microchip'

    candidate_name = /[a ]*(.*)-compatible/.match(i)
    Microchip.new(candidate_name.captures[0].to_sym)
  end

  def self.parse_generators(i)
    return i unless i.is_a? String
    return i unless i.include? 'generator'

    candidate_name = /[a ]*(.*) generator/.match(i)
    Generator.new(candidate_name.captures[0].to_sym)
  end
end