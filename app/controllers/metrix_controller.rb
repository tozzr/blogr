class MetrixController < ApplicationController

  def click
    @click = Metrix::Click.new(click_params)
    @click.session_id = request.session_options[:id]
    if @click.save
      render json: {}, status: :created
    else
      #format.json { render json: @article.errors, status: :unprocessable_entity }
    end
  end

  private 

    def click_params
      params.permit(
        :location, 
        :mouse_x, :mouse_y, 
        :document_w, :document_h, 
        :screen_w, :screen_h, 
        :window_w, :window_h
      )
    end
end
