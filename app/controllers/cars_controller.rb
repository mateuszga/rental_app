class CarsController < ApplicationController
	before_action :find_car, only: [:show, :edit, :update, :destroy]
	before_action :authenticate_user!, except: [:index, :show]


	def index
		if params[:category].blank?
			@cars = Car.all.order("created_at DESC")
		else
			@category_id = Category.find_by(name: params[:category]).id
			@cars = Car.where(category_id: @category_id).order("created_at DESC")
		end
		@bookings = Booking.all
	end

	def show
		@bookings = Booking.where(car_id: @car.id).order("created_at DESC")
	end

	def new
		@car = current_user.cars.build
	end

	def create
		@car = current_user.cars.build(car_params)

		if @car.save
			redirect_to @car, notice: "Succesfully created new car"
		else
			render 'new'
		end
	end

	def edit
	end

	def update
		if @car.update(car_params)
			redirect_to @car, notice: "Car was succesfully updated!"
		else
			render 'edit'
		end

	end

	def destroy
		@car.destroy
		@bookings = @car.bookings.where(car_id: @car.id)
		@bookings.destroy_all
		redirect_to root_path
	end

	private

	def car_params
		params.require(:car).permit(:name, :description, :category_id, :image)
	end

	def find_car
		@car = Car.find(params[:id])
	end
end

