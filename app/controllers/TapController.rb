class TapController < UIViewController

  ROWS = 50 
  COLUMNS = 80
  CELL_SIZE = 5 

  OFFSET_X = 20 
  OFFSET_Y = 20 

  def viewDidLoad
    super
    setup
    self
  end

  private

  def setup
    setup_view
    setup_world_and_views
    start_heart_beat
  end

  def setup_view
    self.view = UIView.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    self.view.backgroundColor = UIColor.blackColor
  end

  def setup_world_and_views
    setup_world
    setup_cell_views
  end

  def setup_cell_views
    @cell_views = []
    @world.each do |x,y|
      square = point_and_extension(x,y)
      cell = UIView.alloc.initWithFrame(square)
      cell.backgroundColor = background_color(x,y)
      self.view.addSubview(cell)
      @cell_views << cell
    end
  end

  def point_and_extension(x,y)
    [[OFFSET_X + x*CELL_SIZE, 
      OFFSET_Y + y*CELL_SIZE], 
     [CELL_SIZE, CELL_SIZE]]
  end

  def setup_world
    @world = World.new(ROWS, COLUMNS)
  end

  def start_heart_beat
    @timer = NSTimer.scheduledTimerWithTimeInterval 0.2, target: self, selector: 'heart_beat', userInfo: nil, repeats: true
  end

  def heart_beat
    @world.next_generation
    update_cells_from_world
  end

  def update_cells_from_world
    @world.each do |x,y|
      @cell_views[x * COLUMNS + y].backgroundColor = background_color(x,y)
    end
  end

  def background_color(x,y)
    @world.alive?(x,y) ? UIColor.redColor : self.view.backgroundColor
  end

end
