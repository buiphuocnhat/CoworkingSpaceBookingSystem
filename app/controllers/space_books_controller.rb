class SpaceBooksController < ApplicationController
  def show
    @space = Space.find_by id: params[:id]
    @booking_detail = BookingDetail.new
  end
end
