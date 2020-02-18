class ContactsController < ApplicationController

  def create
    product = Product.find(params[:id])
    if product
      ContactMailer.send_contact(current_user, product).deliver_now
      flash[:success] = "We send a mail to #{product.user.name}, wait his mail...."
      redirect_to products_path
    else
      flash[:danger] = "Ooopss ... mail not send"
      redirect_to products_path
    end

  end

end
