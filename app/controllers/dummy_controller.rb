class DummyController < ApplicationController
  def test
    @pattern = GeoPattern.generate('Mastering Markdown', color: '#fc0')
  end

  # this just downloads the image
  def png
    svg = Search.new.seeded_pattern("Goat").to_svg
    t = Search.svg_to_png(svg,150,150)

    send_data(t , :filename => 'test.png', :type=>'image/png')

  end
end
