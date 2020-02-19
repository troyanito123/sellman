class ContactsController < ApplicationController

  include ProductsHelper

  before_action :send_one

  def create
    product = Product.find(params[:id])
    if product
      ContactMailer.send_contact(current_user, product).deliver_now
      send = Send.new
      send.user = current_user
      send.product = product
      send.save
      flash[:success] = "We send a mail to #{product.user.name}, wait his mail...."
      redirect_to products_path
    else
      flash[:danger] = "Ooopss ... mail not send"
      redirect_to products_path
    end

  end

  private
  def send_one
    if send_contact?(Product.find(params[:id]))
      flash[:warning] = I18n.t 'product.send'
      redirect_to products_path
    end
  end

end
