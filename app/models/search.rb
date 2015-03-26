require "base64"

class Search

  # if you just want to download a png, use this
  # def self.svg_to_png(svg, width, height)
  #width = width of the svg in px
  #height = width of the svg in px
  def svg_to_png(svg, width, height)
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

  # if that png needs to be a data uri, use this
  # def self.encode64( png )
  def encode64( png )
    return Base64.encode64(png)
  end

  # returns a random GeoPattern. Use .to_svg if you want it to be an svg
  def random_pattern
    randomish_string = ('a'..'z').to_a.shuffle.join
    randomish_color = "%06x" % (rand * 0xffffff)
    return GeoPattern.generate(randomish_string, color: randomish_color )
  end

  # returns a GeoPattern of a random color for a given string
  def seeded_pattern( search_term )
    randomish_color = "%06x" % (rand * 0xffffff)
    return GeoPattern.generate(search_term, color: randomish_color )
  end

  # returns a GeoPattern of a random pattern for a given color
  def random_pattern_with_color( hex_color )
    randomish_string = ('a'..'z').to_a.shuffle.join
    return GeoPattern.generate(randomish_string, color: hex_color )
  end

  # returns a data uri for a png with a random color and pattern, of the given dimensions
  #FIXME this does very odd things for anything other than width = 150 and height = 150
  def random_uri_with_resolution( width, height )
    svg = random_pattern.to_svg
    png = svg_to_png( svg, width, height )
    return encode64( png )
  end

  def random_uri_with_color_and_resolution( color, width, height )
    svg = random_pattern_with_color( color ).to_svg
    png = svg_to_png( svg, width, height )
    return encode64( png )
  end

  def random_uri_with_seed_and_resolution( seed, width, height )
    svg = seeded_pattern( seed ).to_svg
    png = svg_to_png( svg, width, height )
    return encode64( png )
  end

  def self.getXML_for_filename( filename )
    xml = ""

    File.open("#{Rails.root}/app/assets/images/#{filename}") do |f|
      xml += f.read
    end

    return xml
  end

end
