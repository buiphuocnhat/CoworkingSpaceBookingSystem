class PaymentsController < ApplicationController
  def show
    @payment = Payment.find(params[:id])
  end

  # def create
  #   @ = .new(params[:])
  # end

  # def update
  #   @ = .find(params[:id])
  # end

  # def edit
  #   @ = .find(params[:id])
  # end

  # def destroy
  #    = .find(params[:id])
  # end
end
