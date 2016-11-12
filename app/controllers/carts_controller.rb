class CartsController < ApplicationController

  def show
    @current_cart = current_user.current_cart 
  end

  def checkout
    @current_cart = current_user.current_cart
    current_user.current_cart.line_items.each do |line_item|
      line_item.item.inventory -= line_item.quantity
      line_item.item.save
    end
    @current_cart.destroy
    redirect_to :back
  end
end
