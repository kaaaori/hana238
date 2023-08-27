class Public::DeliveryAddressesController < ApplicationController
  before_action :authenticate_customer!
  
  def index
    @customer = current_customer
    @delivery_addresses = @customer.delivery_addresses
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
      render :new
    end
  end
  
  def edit
    @delivery_address = DeliveryAddress.find(params[:id])
  end
  
  def update
    @delivery_address = DeliveryAddress.find(params[:id])
    if @delivery_address.update(delivery_address_params)
      flash[:notice] = "変更を保存しました"
      redirect_to delivery_addresses_path
    else
      render :edit
    end
  end
  
  def destroy
    @delivery_address = DeliveryAddress.find(params[:id])
    @delivery_address.destroy
    redirect_to delivery_addresses_path
  end
  
  
  private
  def delivery_address_params
    params.require(:delivery_address).permit(:customer_id, :address_name, 
    :postal_code, :phone_number, :prefecture_code, :address_city, :address_street, :address_building)
  end
end
