class FlightsController < ApplicationController
  def index
    if params[:q]
      @flight = Flight.ransack(departured_id_eq: params[:q]["departured_id"],
                        arrived_id_eq: params[:q]["arrived_id"],
                        user_id_eq: params[:q]["user_id"],
                        departured_iata_code_eq: params[:q]["departured_iata_code"],
                        arrived_iata_code_eq: params[:q]["arrived_iata_code"],
                        user_email_start: params[:q]["user_email"])
    else
      @flight = Flight.ransack(params[:q])
    end
    @flights = @flight.result
    @flights ||= Flight.all.order('created_at DESC')
  end

  def show
    @flight = Flight.find(params[:id])
  end

  def update
    @flight = Flight.find(params[:id])
    authorize @flight
    respond_to do |format|
      if @flight.update(flight_params)
        format.html { redirect_to edit_flight_path(@flight), notice: t('updated_flight_message') }
      else
        format.html { render :edit }
      end
    end
  end

  def create
    @flight = Flight.new(flight_params.merge(user_id: current_user.id))
    respond_to do |format|
      if @flight.save
        format.html { redirect_to edit_flight_path(@flight), notice: t('created_flight_message') }
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
    params.require(:flight).permit(:user_id, :departured_id, :arrived_id)
  end
end
