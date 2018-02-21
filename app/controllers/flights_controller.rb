class FlightsController < ApplicationController
  def index
    @flights = Flight.all.order('created_at DESC')
  end

  def show
    @flight = Flight.find(params[:id])
  end

  def update
    @flight = Flight.find(params[:id])
    authorize @flight
    respond_to do |format|
      if @flight.update(flight_params)
        format.html { redirect_to edit_flight_path(@flight), notice: 'Vuelo cambiado correctamente.' }
      else
        format.html { render :edit }
      end
    end
  end

  def create
    @flight = Flight.new(flight_params.merge(user_id: current_user.id))
    respond_to do |format|
      if @flight.save
        format.html { redirect_to edit_flight_path(@flight) }
      else
        format.html do
          render :new
        end
      end
    end
  end

  def edit
    @flight = Flight.find(params[:id])
  end

  def new
    @flight = Flight.new
  end

  private

  def flight_params
    params.require(:flight).permit(:user_id, :departured_id, :arrived_id)
  end
end
