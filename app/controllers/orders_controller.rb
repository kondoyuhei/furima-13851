class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item_and_user, only: [:index, :create]
  before_action :item_available, only: [:index, :create]
  before_action :confirm_seller, only: [:index, :create]

  def item_available
    @item = Item.find(params[:item_id])
    return if @item.on_sale

    # 売り切れであればトップページに遷移する
    flash[:notice] = "この商品は売り切れです。購入できません。"
    redirect_to root_path
  end

  def confirm_seller
    @item = Item.find(params[:item_id])
    return unless @item.owner(current_user)

    # 出品者が自分の商品の購入ページにアクセスしたらトップページに遷移する
    flash[:notice] = "この商品の出品者です。購入できません"
    redirect_to root_path
  end

  def set_item_and_user
    @item = Item.find(params[:item_id])
    @user = current_user
  end

  def index
  end

  def create
    @order = Purchase.new(order_params)
  end

  private

  def order_params
    params.permit(:item, ).merge(user: current_user)
  end
end
