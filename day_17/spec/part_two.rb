require_relative('../vault_simulator.rb')
require_relative('../vault_cracker.rb');
require_relative('../vault.rb')

# --- Part Two ---

# You're curious how robust this security solution really is, and so you
# decide to find longer and longer paths which still provide access to the
# vault. You remember that paths always end the first time they reach the
# bottom-right room (that is, they can never pass through it, only end in it).

# For example:

# If your passcode were ihgpwlah, the longest path would take 370 steps.
# With kglvqrro, the longest path would be 492 steps long.
# With ulqzkmiv, the longest path would be 830 steps long.
# What is the length of the longest path that reaches the vault?

# Your puzzle input is still mmsxrhfx.

describe "day 17 - part two" do

  it "can find the longest path for ihgpwlah" do
    simulator = VaultSimulator.new([3,3])
    
    vault = simulator.longest_path_from Vault.new("ihgpwlah", '', [0,0])
    expect(vault.path.length).to eq 370
  end

  it "can find the longest path for kglvqrro" do
    simulator = VaultSimulator.new([3,3])
    
    vault = simulator.longest_path_from Vault.new("kglvqrro", '', [0,0])
    expect(vault.path.length).to eq 492
  end

  it "can find the longest path for ulqzkmiv" do
    simulator = VaultSimulator.new([3,3])
    
    vault = simulator.longest_path_from Vault.new("ulqzkmiv", '', [0,0])
    expect(vault.path.length).to eq 830
  end

  it "can find the longest path for puzzle input" do
    simulator = VaultSimulator.new([3,3])
    
    vault = simulator.longest_path_from Vault.new("mmsxrhfx", '', [0,0])
    p "the longest path is #{vault.path.length} long" 
  end
end