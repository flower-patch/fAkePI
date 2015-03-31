class DummyController < ApplicationController
  def test
    @pattern = GeoPattern.generate('Mastering Markdown', color: '#fc0')
  end

  def svg_input
    @link = "moo"
    @svg = Search.new.seeded_pattern("Goat").to_svg
    @local_stored_svg = Search.getXML_for_filename( "test_goat.svg" )

  end

  def download_svg
    pattern = GeoPattern.generate('Mastering Markdown', patterns: :sine_waves)
    # pattern = GeoPattern.generate('Mastering Markdown', color: '#fc0')

    send_data(pattern.to_svg , :filename => 'test.svg', :type=>'image/svg+xml')
  end

  # this just downloads the image of an arbitrary svg
  #FIXME not in routes yet
  def png_download
    svg = Search.new.seeded_pattern("Goat").to_svg
    t = Search.svg_to_png(svg,150,150)

    send_data(t , :filename => 'test.png', :type=>'image/png')
  end

  #FIXME has no view
  def png
    svg = Search.new.seeded_pattern("Goat").to_svg
    @png = Search.svg_to_png(svg,150,150)
  end
end
