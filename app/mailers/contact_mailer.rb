class ContactMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.contact_mailer.send_contact.subject
  #
  def send_contact(user, product)
    @user = user
    @product = product
    mail to: product.user.email, subject: "#{user.name} is interested on your products "
  end
end
