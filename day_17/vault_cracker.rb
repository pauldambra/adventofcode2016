require 'digest'
class VaultCracker
  @door_pattern = /[bcdef]/

  def self.directions(i)
    hashcode = Digest::MD5.hexdigest(i)
    c = hashcode.slice(0,4).chars
    r = Hash.new
    r[:up] = @door_pattern =~ c[0] ? :open : :closed
    r[:down] = @door_pattern =~ c[1] ? :open : :closed
    r[:left] = @door_pattern =~ c[2] ? :open : :closed
    r[:right] = @door_pattern =~ c[3] ? :open : :closed
    r
  end
end