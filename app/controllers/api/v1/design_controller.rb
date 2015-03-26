class Api::V1::DesignController < ApplicationController

  before_action :add_cors_headers


  def previewImage

    default_width = params[:preview_width_pixels].to_i
    default_height = params[:preview_height_pixels].to_i
    currently_discarded = params[:print_height]
    currently_discarded = params[:print_width]

    result_array = []

    if params[:id]
      svg = Search.new.random_pattern.to_svg
      png = Search.new.svg_to_png(svg, default_width, default_height)
    end

    send_data( png , :filename => 'test.png', :type=>'image/png', disposition: 'inline')
  end

  # default: return 10 results
  def search
    default_width = 150
    default_height = 150
    result_array = []

    if params[:color1]
      10.times do |i|
        data_uri = Search.new.random_uri_with_color_and_resolution( params[:color1], default_width, default_height )
        result_array << { id: i*1000,
                          thumbnail_url: "data:image/png;base64,#{data_uri}" }
      end
    end

    if params[:limit]
      params[:limit].to_i.times do |i|
        data_uri = Search.new.random_uri_with_resolution( default_width, default_height)
        result_array << { id: i*1000,
                          thumbnail_url: "data:image/png;base64,#{data_uri}" }
      end
    end

    if params[:q]
      10.times do |i|
        data_uri = Search.new.random_uri_with_seed_and_resolution( params[:q], default_width, default_height )
        result_array << { id: i*1000,
                          thumbnail_url: "data:image/png;base64,#{data_uri}" }
      end
    end

    render json: { results: [ {results: result_array} ] }

  end

  def add_cors_headers
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = 'POST, GET, OPTIONS'
    headers['Access-Control-Allow-Headers'] = '*'
    headers['Access-Control-Max-Age'] = "1728000"
  end

  # design/search?availability=for_sale&substrate=fabric&color1=#{color1}

  # http://api.v1.spoonflower.com/design/search?q=#{search_term}

end
