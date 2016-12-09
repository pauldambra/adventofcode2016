require_relative('../common/array.rb')

class ErrorCorrectingReader
  def self.read(all_lines)
    chunk_input(all_lines)
            .map { |c| get_char_frequency c }
            .map do |c|
              c.sort_by { |k,v| v }
               .reverse
               .take(1)
            end
            .map { |c| c[0][0] }.join('')
  end

  def self.read_least_common(all_lines)
    chunk_input(all_lines)
            .map { |c| get_char_frequency c }
            .map do |c|
              c.sort_by { |k,v| v }
               .take(1)
            end
            .map { |c| c[0][0] }.join('')
  end

  private

  def self.chunk_input(i)
    all_lines = i.map(&:chomp).select { |l| l.length > 0 }

    input_width = all_lines[1].length
    input_height = all_lines.count
    
    all_lines.chunk_columns_of_characters_by(input_width, input_height)
  end

  def self.get_char_frequency(cs)
    cs.group_by(&:chr).map { |k, v| [k, v.size] }
  end
end