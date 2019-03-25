class FlightsController < ApplicationController
  def index
    @q = Flight.ransack(params[:q])
    @flights = @q.result(distinct: true)
    @flights = @flights.order('departured_date DESC')
    @my_flights = params[:user] ? true : false
    render status: :ok
  end

  def show
    @flight = Flight.find(params[:id])
  end

  def update
    @flight = Flight.find(params[:id])
    authorize @flight
    respond_to do |format|
      if @flight.update(flight_params)
        format.html { redirect_to flight_path(@flight), notice: t('updated_flight_message') }
      else
        format.html { render :edit }
      end
    end
  end

  def create
    @flight = Flight.new(flight_params)
    respond_to do |format|
      if @flight.save
        format.html { redirect_to flight_path(@flight) }
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

  def destroy
    @flight = Flight.find(params[:id])
    authorize @flight
    @flight.destroy
    respond_to do |format|
      format.html { redirect_to flights_path, notice: 'Vuelo borrado correctamente' }
    end
  end

  private

  def flight_params
    params.require(:flight).permit(:user_id, :departured_id, :arrived_id, :departured_date)
  end
end
