class PlacesController < ApplicationController
  before_action :set_place, only: [:show]
  def index
  end

  def search
    @places = BeermappingApi.places_in(params[:city])
    if @places.empty?
      redirect_to places_path, notice: "No locations in #{params[:city].titlecase}"
    else
      session[:city] = params[:city]
      @weather = BeerweatherApi.get_weather(params[:city])
      render :index, status: 418
    end
  end

  def show
  end

  def set_place
    @place_id = params[:id]
  end
end
