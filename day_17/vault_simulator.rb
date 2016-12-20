class VaultSimulator
  
  def initialize(target_coord)
    @target_coord = target_coord
    @found_path = nil
  end

  def shortest_path_from(vault)
    seek_shortest_path([vault])
    @found_path
  end

  def longest_path_from(vault)
    seek_longest_path([vault])
    @found_path
  end

  def seek_longest_path(parents)
    child_vaults, found_targets, still_seeking = bfs(parents)
    
    if child_vaults.empty?
      p "dead end"
    else

      if !found_targets.empty?
        keep_longest_path(found_targets)
      end

      if !still_seeking.empty?
        seek_longest_path(still_seeking)
      end
    end
  end

  def seek_shortest_path(parents)
    parents = prune_paths_longer_than_discovered(parents)
    walk_tree(parents)
  end

  private

  def walk_tree(parents)
    child_vaults, found_targets, still_seeking = bfs(parents)
    
    if child_vaults.empty?
      p "dead end"
    else

      if !found_targets.empty?
        keep_shortest_path(found_targets)
      end

      if !still_seeking.empty?
        seek_shortest_path(still_seeking)
      end
    end
  end

  def keep_shortest_path(found_targets)
    @found_path = ([@found_path] + found_targets)
                          .reject { |x| x == nil }
                          .min_by { |x| x && x.path.length }
  end

  def keep_longest_path(found_targets)
    @found_path = ([@found_path] + found_targets)
                          .reject { |x| x == nil }
                          .max_by { |x| x && x.path.length }
  end

  def bfs(parents)
    child_vaults = parents.reduce([]) {|total, p| total.push(p.next_options)}
                          .flatten

    found_targets = child_vaults.flatten.select {|c| c.position == @target_coord}
    still_seeking = child_vaults.flatten.select {|c| c.position != @target_coord}

    [child_vaults, found_targets, still_seeking]
  end

  def prune_paths_longer_than_discovered(parents)
    if @found_path != nil
      parents = parents.reject do |p| 
                                p.path.length > @found_path.path.length
                               end
    end
    parents
  end
end