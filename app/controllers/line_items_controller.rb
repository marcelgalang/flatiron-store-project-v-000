class LineItemsController < ApplicationController

  def create
    user_item = Item.find(params[:item_id])
    current_user.current_cart ||= Cart.create(status: "shopping")
    if current_user.current_cart.items.include?(user_item)
      user_line_item = LineItem.find_by(item: user_item, cart: current_user.current_cart)
      user_line_item.quantity += 1
      user_line_item.save
    else
      current_user.current_cart.items << user_item
    end
    current_user.save
    redirect_to cart_path(current_user.current_cart)
  end
end
