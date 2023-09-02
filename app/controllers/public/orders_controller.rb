class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!
  def new
    @order = Order.new
    if current_customer.cart_items.empty?
      redirect_to cart_items_path
    end
  end
  
  def confirm
    @order = Order.new(order_params)
    if params[:order][:select_address] == "0"
      @order.postal_code = current_customer.postal_code
      @order.prefecture_code = current_customer.prefecture_code
      @order.address_city = current_customer.address_city
      @order.address_street = current_customer.address_street
      @order.address_building = current_customer.address_building
      @order.address_name = current_customer.last_name + current_customer.first_name
    elsif params[:order][:select_address] == "1"
      @address = DeliveryAddress.find(params[:order][:delivery_address_id])
      @order.postal_code = @address.postal_code
      @order.prefecture_code = @address.prefecture_code
      @order.address_city = @address.address_city
      @order.address_street = @address.address_street
      @order.address_building = @address.address_building
      @order.address_name = @address.address_name
    elsif params[:order][:select_address] == "2"
    end
      @cart_items = current_customer.cart_items
  end
  
  def create
    byebug
  end
  
  def index
    @orders = current_customer.orders
    @order_details = OrderDetail.where(order_id: params[:id])
  end
  
  private
    def order_params
      params.require(:order).permit(:payment_method, :postal_code, :prefecture_code, :address_city, :address_street, :address_building, :address_name, :postage, :total, :customer_id, :delivery_day, :delivery_time)
    end
end
