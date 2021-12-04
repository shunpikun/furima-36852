class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item
  before_action :set_card

  def index
    @order_address = OrderAddress.new
    redirect_to root_path and return if @item.order.present?

    redirect_to root_path if current_user.id == @item.user.id
  end

  def create
    @order_address = OrderAddress.new(order_params)
    if @order_address.valid?
      pay_item
      @order_address.save
      redirect_to root_path
    else
    render :index
    end
  end

  private

  def order_params
    item = Item.find(params[:item_id])
    params.require(:order_address).permit(:postal_code, :prefecture_id, :city, :house_number, :building_name, :phone_number).merge(
      user_id: current_user.id, item_id: item.id
    )
  end

  def pay_item
    redirect_to new_card_path and return unless current_user.card.present?

    Payjp.api_key = ENV["PAYJP_SECRET_KEY"] # 環境変数を読み込む
    customer_token = current_user.card.customer_token # ログインしているユーザーの顧客トークンを定義
    Payjp::Charge.create(
      amount: @item.price, # 商品の値段
      customer: customer_token, # 顧客のトークン
      currency: 'jpy' # 通貨の種類（日本円）
    )
  end

  def set_item
    @item = Item.find(params[:item_id])
  end

  def set_card
    redirect_to new_card_path and return unless current_user.card.present?
  end
end
