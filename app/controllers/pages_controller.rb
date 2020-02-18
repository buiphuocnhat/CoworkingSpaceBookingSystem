class PagesController < ApplicationController
  before_action :index, only: [:filter]
  require "will_paginate/array"
  def index
    if params[:name].blank? && params[:city].blank?
      @spaces = Space.joins(venue: :address).all
    elsif params[:city].blank?
      @search_name = params[:name]
      @spaces = Space.search_name(@search_name)
    elsif params[:name].blank?
      @search_city = params[:city]
      @spaces = Space.search_city(@search_city)
    else
      @search_name = params[:name]
      @search_city = params[:city]
      @spaces = Space.search_name(@search_name).search_city(@search_city)
    end
    #@arrSpaces = @spaces.to_a
    @arrSpaces = @spaces
    if params[:start_date].blank? || params[:end_date].blank?
      flash.now[:error] = "Nhap vao ngay thang"
    elsif (Date.parse(params[:start_date]) < Date.current) || (Date.parse(params[:end_date]) < Date.current) || (Date.parse(params[:start_date]) > Date.parse(params[:end_date]))
      flash[:error] = "Ban nhap sai ngay"
    else
      start_date = Date.parse(params[:start_date])
      end_date = Date.parse(params[:end_date])
      @spaces.each do |space|
        not_available = space.booking_details.where(
          "(? <= booking_details.time_use_start AND booking_details.time_use_start <= ?)
          OR (? <= booking_details.time_use_close AND booking_details.time_use_close <= ?)
          OR (booking_details.time_use_start < ? AND ? < booking_details.time_use_close)",
          start_date, end_date,
          start_date, end_date,
          start_date, end_date
        ).limit(1)
        # @arrSpaces.delete(space) unless not_available.empty?
        @arrSpaces = @arrSpaces.where.not(id: space.id) unless not_available.empty?
      end
    end
    def filter
    @arr_type = []
    @arr_type << 1 if params[:private_office].present?
    @arr_type << 2 if params[:metting_room].present?
    @arr_type << 3 if params[:desk].present?
    @results = @arrSpaces.where.not("spaces.type_id IN ?", @arr_type)
    end
    #@arrSpaces = @arrSpaces.paginate(page: params[:page], per_page: 8)
    @results=@arrSpaces.paginate(page: params[:page], per_page: 8)
    byebug
  end

end
