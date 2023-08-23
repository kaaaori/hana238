class Public::DeliveryAddressesController < ApplicationController
  before_action :authenticate_customer!
  
  def index
    @customer = current_customer
    @delivery_address = DeliveryAddress.all
  end
  
  def new
    @delivery_address = DeliveryAddress.new
  end
  
  def create
    @delivery_address = DeliveryAddress.new(delivery_address_params)
    if @delivery_address.save
      flash[:notice] = '新規登録しました'
      redirect_to delivery_addresses_path
    else
      render :index
    end
  end
  
  def edit
    
  end
  
  private
  def delivery_address_params
    params.require(:delivery_address).permit(:customer_id, :address_name, :postal_code, :address, :phone_number)
  end
end
