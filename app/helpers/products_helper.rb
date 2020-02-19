module ProductsHelper

  def send_contact?(product)
    res = false
    sends = current_user.sends
    sends.each do |send|
      if send.product == product
        res = true
        break
      end
    end
    return res
  end
end
