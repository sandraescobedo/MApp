class FlightsController < ApplicationController
  def index
    @flights = Flight.by_user(current_user)
  end

  def show

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
    redirect_to flights_path
  end

  def new
    @flight = Flight.new
  end

  private

  def flight_params
    params.require(:flight).permit(:user_id, :departured_id, :arrived_id)
  end
end
