module ProductModule
  class ProductSend

    def save_product(user, product)
      send = Send.new
      send.user = user
      send.product = product
      send.save
    end

  end
end