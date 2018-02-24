class AirportsController < ApplicationController
  def index
    @airports = Airport.all
  end

  def show
    @airport = Airport.find(params[:id])
  end

  def update
    @airport = Airport.find(params[:id])
    respond_to do |format|
      if @airport.update(airport_params)
        format.html { redirect_to edit_airport_path(@airport), notice: 'Aeropuerto cambiado correctamente.' }
      else
        format.html { render :edit }
      end
    end
  end

  def create
    @airport = Airport.new(airport_params)
    respond_to do |format|
      if @airport.save
        format.html { redirect_to edit_airport_path(@airport) }
      else
        format.html do
          render :new
        end
      end
    end
  end

  def edit
    @airport = Airport.find(params[:id])
  end

  def new
    @airport = Airport.new
  end

  def destroy
    @airport = Airport.find(params[:id])
    @airport.destroy
    respond_to do |format|
      format.html { redirect_to airports_path, notice: 'Aeropuerto borrado correctamente' }
    end
  end

  private

  def airport_params
    params.require(:airport).permit(:iata_code, :name, :city, :address)
  end
end
