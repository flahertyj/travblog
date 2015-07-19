class LocationsController < ApplicationController

  def create
    @location = Location.new(name: params[:location][:name])

    respond_to do |format|
      if @location.save
        format.html { redirect_to '/', notice: 'New location was successfully saved.' }
      else
        format.html { redirect_to '/', notice: 'New location was not successfully saved.' }
      end
    end
  end

  private

    def location_params
      # It's mandatory to specify the nested attributes that should be whitelisted.
      # If you use `permit` with just the key that points to the nested attributes hash,
      # it will return an empty hash.
      params.require(:location).permit(:name, :latitude, :longitude)
    end
end
