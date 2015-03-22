class Search

  def self.svg_to_png(svg, width, height)
    svg = RSVG::Handle.new_from_data(svg)
    width   = width  ||=500
    height  = height ||=500
    surface = Cairo::ImageSurface.new(Cairo::FORMAT_ARGB32, width, height)
    context = Cairo::Context.new(surface)
    context.render_rsvg_handle(svg)
    b = StringIO.new
    surface.write_to_png(b)
    return b.string
  end

  def random_pattern
    randomish_string = ('a'..'z').to_a.shuffle.join
    randomish_color = "%06x" % (rand * 0xffffff)
    return GeoPattern.generate(randomish_string, color: randomish_color )
  end

  def seeded_pattern( search_term )
    randomish_color = "%06x" % (rand * 0xffffff)
    return GeoPattern.generate(search_term, color: randomish_color )
  end

  def random_pattern_with_color( hex_color )
    randomish_string = ('a'..'z').to_a.shuffle.join
    return GeoPattern.generate(randomish_string, color: hex_color )
  end

end
