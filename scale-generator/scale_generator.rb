class Scale

  attr_reader :root, :type, :intervals

  CHROMATIC_SCALE = %w(A A# B C C# D D# E F F# G G#)
  CHROMATIC_SCALE_FLAT = %W(A Bb B C Db D Eb E F Gb G Ab)

  def initialize(root, type, intervals = 'mmmmmmmmmmmm')
    @root = format_root(root)
    @type = type
    @intervals = intervals
  end

  def name
    "#{root} #{type.to_s}"
  end

  def pitches
    build_scale
  end

  private

  def use_sharps?
    %w(G D A E C B F#).include?(root) && type == "major".to_sym ||
      %w(E B F# C# G# D#).include?(root) && type == "minor".to_sym ||
      root == 'C' && type == "chromatic".to_sym ||
      type == "lydian".to_sym || 
      type == "octatonic".to_sym ||
      type == "pentatonic".to_sym ||
      type == "enigma".to_sym
  end

  def build_scale
    scale = []
    index = 0
    chromatic = build_chromatic

    while scale.length < index_list.length
      scale << chromatic[index_list[index]]
      index += 1
    end
    scale
  end

  def index_list
    index_list = [0]

    convert_intervals.each do |x|
      index_list << index_list.last + x
    end

    index_list.pop
    index_list
  end

  def format_root(root_note)
    x = root_note.split("")
    x[0] = x[0].upcase
    x.join
  end

  def convert_intervals
    intervals.split("").map do |int|
       if int == "m"
         1 
       elsif int == "M"
         2
       elsif int == "A"
        3
       end 
    end
  end

  def build_chromatic
    scale = []
    x = use_sharps? ? CHROMATIC_SCALE : CHROMATIC_SCALE_FLAT
    start_index = x.index(root)

    while scale.length < 12
      scale << x[start_index]
      start_index += 1
      start_index = 0 if x[start_index] == nil
    end
    scale
  end

end
