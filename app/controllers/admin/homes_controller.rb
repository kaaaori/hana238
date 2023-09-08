class Admin::HomesController < ApplicationController
  def top
      @orders = Order.all
      @customers = Customer.page(params[:page]).per(15)
  end
end