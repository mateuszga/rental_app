class BookingsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_booking, only: [:show, :edit, :update, :destroy]
  before_action :set_car

  def index
    @bookings = Booking.all
  end

  def show
  end

  def new
    @booking = current_user.bookings.build
  end

  def edit
    
  end

  def create
    @booking = current_user.bookings.build(booking_params)
    @booking.car_id = @car.id

      if @booking.save
        redirect_to @car, notice: 'Booking was successfully created.'
      else
        render :new
      end
    
  end

  def update
      @booking.car_id = @car.id
      if @booking.update(booking_params)
        redirect_to @car, notice: 'Booking was successfully updated.'
      else
        render :edit
      end
    
  end

  def destroy
    @booking.destroy
    redirect_to @car, notice: 'Booking was successfully destroyed.'

  end

  private
    def set_booking
      @booking = Booking.find(params[:id])
    end

    def set_car
      @car = Car.find(params[:car_id])
    end

    def booking_params
      params.require(:booking).permit(:customer_name, :comment, :booked_from, :booked_to, :price)
    end
    
end
