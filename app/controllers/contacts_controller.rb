class ContactsController < ApplicationController

  def create
    @product = Product.find(params[:id])
    @success = false
    if @product
      send = ProductModule::ProductSend.new
      if send.save_product(current_user, @product)
        # ContactMailer.delay(run_at: 5.minutes.from_now).send_contact(current_user, product)
        @success = true
        flash.now[:success] = "We send a mail to #{@product.user.name}, wait his mail...."
      else
        flash[:danger] = "Ooopss ... mail not send"
      end
    else
      flash[:danger] = "product not found!"
    end
  end

end
