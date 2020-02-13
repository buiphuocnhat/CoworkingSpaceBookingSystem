class PagesController < ApplicationController
  require "will_paginate/array"
  def index
    if params[:name].blank? && params[:city].blank?
      @spaces = Space.joins(venue: :address).all
    elsif params[:city].blank?
      @search_name = params[:name]
      @spaces = Space.joins(venue: :address).where("addresses.name like '%#{@search_name}%'")
    elsif params[:name].blank?
      @search_city = params[:city]
      @spaces = Space.joins(venue: :address).where("addresses.city like '%#{@search_city}%'")
    else
      @search_name = params[:name]
      @search_city = params[:city]
      @spaces = Space.joins(venue: :address).where("addresses.city like '%#{@search_city}%'&& addresses.name like '%#{@search_name}%'")
    end
    @arrSpaces = @spaces.to_a
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
        if not_available.size > 0
          @arrSpaces.delete(space)
        end
      end
    end
    @arrSpaces = @arrSpaces.paginate(page: params[:page], per_page: 8)
  end
end
