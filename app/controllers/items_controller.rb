class ItemsController < ApplicationController
  # ログイン確認をする
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_item, only: [:show, :edit]
  before_action :confirm_user, only: [:edit, :update, :destroy]

  def confirm_user
    @item = Item.find(params[:id])
    return unless @item.user_id != current_user.id

    flash[:notice] = "権限がありません"
    redirect_to root_path
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def index
    @items = Item.includes(:user).order(created_at: :DESC)
  end

  def show
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      flash[:notice] = "商品を出品しました"
      redirect_to item_path(@item.id)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @item.update(item_params)
      flash[:notice] = "商品の情報を更新しました"
      redirect_to item_path(@item.id)
    else
      render :edit
    end
  end

  def destroy
  end

  private

  def item_params
    params.require(:item).permit(
      :name, :note, :price, :image, :category, :condition,
      :charge, :from, :period
    ).merge(user_id: current_user.id)
  end
end
