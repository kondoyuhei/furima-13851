class ItemsController < ApplicationController
  # ログイン確認をする
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @items = Item.includes(:user).order(created_at: :DESC)
    @purchases = Purchase.all
  end

  def show
    @item = Item.includes(:user).find(params[:id])
    @purchases = Purchase.all
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to item_path(@item.id)
    else
      render :new
    end
  end

  def edit
  end

  def update
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
