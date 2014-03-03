# Conway's Game of life World model

# Use like this
# w = World.new(30,120)
# w.clear
# 
# w.set_cell(3,6,1)
# w.set_cell(3,7,1)
# w.set_cell(3,8,1)
# 
# w.loop

class World
  attr_accessor :cells, :x, :y

  def initialize(x, y)
    self.x, self.y = x, y
    setup_cells
  end
  
  def next_generation
    cells_clone = cells.clone
    each { |x,y| cells_clone[index(x,y)] = next_state(x,y) }
    self.cells = cells_clone
  end

  def alive?(i,j)
    cell(i,j) == 1
  end

  def each
    @x.times do |x|
      @y.times do |y|
        yield x, y, cell(x,y)
      end
    end 
  end

  def set_cell(x, y, value)
    self.cells[index(x,y)] = value
  end

  private

  def clear
    each { |x,y| set_cell(x,y,0) }
  end

  def print_cell(x,y)
    alive?(x,y) ? "#" : " "
  end

  def next_state(x, y)
    total = total_alive_neighbours(x,y)
    if alive?(x,y)
      [2,3].include?(total) ? 1 : 0
    else
      total == 3 ? 1 : 0
    end
  end

  def total_alive_neighbours(x,y)
    neighbours(x, y).reduce(0) { |sum, i| sum += i }
  end

  def setup_cells
    @cells = []
    each { |x,y| cells << init_value }
  end

  def init_value
    rand(100) > 80 ? 1 : 0
  end

  def index(x, y)
    (x*self.y) + y
  end

  def cell(x, y)
    cells[index(x,y)]
  end

  def neighbours(x, y)
    neighbours = []

    [-1,0,1].each do |delta_x| 
      [-1,0,1].each do |delta_y|
        neighbours << neighbour(x, delta_x, y, delta_y) unless delta_x == 0 && delta_y == 0
      end
    end

    neighbours
  end

  def neighbour(x, delta_x, y, delta_y)
    cell(neighbouring_coordinate(x, delta_x, @x), neighbouring_coordinate(y, delta_y, @y))
  end

  def neighbouring_coordinate(coordinate, delta, max)
    neighbour = coordinate + delta

    if neighbour < 0 
      max - 1
    elsif neighbour >= max
      0
    else
      neighbour
    end
  end
end
