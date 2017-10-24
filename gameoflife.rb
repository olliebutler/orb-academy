require 'io/console'
class Game
  def initialize(w,h)
    @grid = Array.new(h) do
      Array.new(w) { random_cell }
    end
  end

  def state
    @grid.map do |row|
      print_row(row).join
    end.join("\n")
  end

  def print_row(row)
    row.map do |cell|
      cell == 1 ? '# ' : '  '
    end
  end

  def tick
    @grid = @grid.map.with_index do |row,i|
      row.map.with_index.map do |cell, j|
        update_cell(neighbours(i, j).sum, cell)
      end
    end
  end

  def random_cell
    if rand(2) == 0
      1
    else
      0
    end
  end

  def update_cell(alive_neighbours, alive)
    if alive == 1
      update_alive(alive_neighbours)
    else
      update_dead(alive_neighbours)
    end
  end

  def update_alive(alive_neighbours)
    if alive_neighbours < 2 || alive_neighbours > 3
      return 0
    else
      return 1
    end
  end

  def update_dead(alive_neighbours)
    if alive_neighbours == 3
      return 1
    else
      return 0
    end
  end

  def neighbours(i, j)
    offset.map do |offset_i, offset_j|
      lookup(i + offset_i, j + offset_j)
    end.compact
  end

  def lookup(i, j)
    row = @grid[i]
    if row != nil
      row[j]
    end
  end

  def offset
    [
      [-1, -1], [0, -1], [1, -1],
      [-1,  0],          [1,  0],
      [-1,  1], [0,  1], [1,  1],
    ]
  end
end

height, width = IO.console.winsize
game = Game.new(width/2, height)

1000.times do
  puts game.state
  game.tick
  sleep 0.1
end
