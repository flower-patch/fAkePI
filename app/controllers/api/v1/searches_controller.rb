class Api::V1::SearchesController < ApplicationController

  # def get
  #   svg = Block.new( params[:block_id] )
  #
  #   render xml: svg.getXML
  # end

  def list
    render json: { links: "these are some links" }
  end

  # design/search?availability=for_sale&substrate=fabric&color1=#{color1}

end
