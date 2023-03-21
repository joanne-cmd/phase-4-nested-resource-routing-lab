class ItemsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_record_not_found_response

  def index
    if params[:user_id]
      user= User.find(params[:user_id])
      items = user.items
    else
      items = Item.all
    end
    render json: items, include: :user, status: :ok
  end

  def show
      items = Item.find(params[:id])
      render json: items, status: :ok

  end

  def create
    user = User.find(params[:user_id])
    item = user.items.create(item_params)
    return render json: item, status: :created
  end

  private

  def item_params
    params.permit(:name, :description, :price)
  end

  def render_record_not_found_response
    render json: {error: "User not found"}, status: :not_found
  end

end
