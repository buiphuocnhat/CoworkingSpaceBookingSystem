class PagesController < ApplicationController
  def index
    @spaces = Space.joins(venue: :address).search_name(params[:name]).search_city(params[:city])
    $arrSpaces = @spaces
    # return if check_day_input params[:start_date], params[:end_date]
    if params[:start_date].present? && params[:end_date].present?
      start_date = Date.parse(params[:start_date])
      end_date = Date.parse(params[:end_date])
    end
    @spaces.each do |space|
      not_available = space.booking_details.where(
        "(? <= booking_details.time_use_start AND booking_details.time_use_start <= ?)
        OR (? <= booking_details.time_use_close AND booking_details.time_use_close <= ?)
        OR (booking_details.time_use_start < ? AND ? < booking_details.time_use_close)",
        start_date, end_date,
        start_date, end_date,
        start_date, end_date
      ).limit(1)
      $arrSpaces = $arrSpaces.where.not(id: space.id) unless not_available.empty?
    end
    @results = $arrSpaces.paginate(page: params[:page], per_page: 8)
  end

  def filter
    @arr_type = []
    @arr_type << 1 if params[:private_office].present?
    @arr_type << 2 if params[:metting_room].present?
    @arr_type << 3 if params[:desk].present?
    $arrSpaces = if @arr_type.empty?
                   $arrSpaces
                 else
                   $arrSpaces.where("spaces.type_id IN ('?') ", @arr_type)
                 end
    @results = $arrSpaces.paginate(page: params[:page], per_page: 8)
    render :index
  end

  # private
  # def check_day_input start_date, end_date
  #   if start_date.blank? || end_date.blank?
  #     flash[:error] = "Nhap vao ngay thang"
  #     redirect_to search_path
  #   elsif (Date.parse(:start_date) < Date.current) || (Date.parse(end_date) < Date.current) || (Date.parse(start_date) > Date.parse(end_date))
  #     flash[:error] = "Ban nhap sai ngay"
  #     redirect_to search_path
  #   end
  # end
end
