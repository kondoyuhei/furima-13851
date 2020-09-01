class OrdersController < ApplicationController
  require 'active_support'
  before_action :authenticate_user!
  before_action :item_available, only: [:index, :create]
  before_action :prohibit_buy_back, only: [:index, :create]

  def item_available
    @item = Item.find(params[:item_id])
    return if @item.on_sale

    # 売り切れであればトップページに遷移する
    flash[:notice] = "アクセスした商品は売り切れです。"
    redirect_to root_path
  end

  def prohibit_buy_back
    @item = Item.find(params[:item_id])
    return unless @item.owner(current_user)

    # 出品者が自分の商品の購入URLにアクセスしたらトップページに遷移する
    flash[:notice] = "出品者が自分の出品した商品を購入することはできません。"
    redirect_to root_path
  end

  def index
    @order = PurchaseShipping.new
  end

  def create
    @item = Item.find(params[:item_id])
    purchase = Purchase.new(
      user_id: purchase_params[:user_id],
      item_id: purchase_params[:item_id]
    )
    if purchase.save
      order_params = purchase_params.except(:token, :price)
      pay_item
      # @order.save
      flash[:notice] = "商品を購入しました"
      redirect_to root_path
    end

  end

  private

  def purchase_params
    params.permit(
      :token, :purchase_id, :zip, :prefecture, :city,
      :address, :building, :phone
    ).merge(user_id: current_user.id, item_id: @item.id, price: @item.price)
  end

  def pay_item
    Payjp.api_key = "sk_test_39407efff624d99a308f69de"  # PAY.JPテスト秘密鍵
    Payjp::Charge.create(
      amount: purchase_params[:price],           # 商品の値段
      card: purchase_params[:token], # カードトークン
      currency:'jpy'                 # 通貨の種類(日本円)
    )
  end
end
