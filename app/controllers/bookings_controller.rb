class BookingsController < ApplicationController
  before_action :authentication_user!

  def index
    @bookings = current_user.booking_details.all
    return if @bookings.present?

    flash[:notice] = "You dont't have any bookings"
    redirect_to search_path
  end

  def new
    @booking_detail = current_user.booking_detail.new
  end

  def edit
    @booking_detail = current_user.booking_details.find params[:id]
  end

  def create
    @booking_detail = current_user.booking_details.new(booking_params)
    ActiveRecord::Base.transaction do
      @booking_detail.save!
      days = (@booking_detail.time_use_close - @booking_detail.time_use_start).to_i
      @booking_detail.payments.create!(method: params[:payment_method], total: days * 500, status: false)
      flash[:success] = "your booking is proceeding"
      redirect_to root_path
    end
  rescue ActiveRecord::RecordInvalid
    @booking_detail.valid?
  end

  def update
    if @booking.update booking_params
      flash[:success] = "Update thanh cong"
      redirect_to root_path
    else
      render :edit
    end
  end

  private

  def booking_params
    params.require(:booking_detail).permit(:time_use_start, :time_use_close, :space_id)
  end
end
