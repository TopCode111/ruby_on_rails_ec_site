class UserNotifierMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_notifier_mailer.send_buyer_purchase_info.subject
  #
  def send_buyer_purchase_info(order)
    @order = order
    @buyer = order.buyer
    @last_name = @buyer.last_name
    @first_name = @buyer.first_name
    @address_1 = @order.billing_address_1
    @address_2 = @order.billing_address_2
    @prefecture = @order.billing_prefecture
    mail to: @buyer.email, subject: "【Pick】ご注文ありがとうございます（自動送信メール）"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_notifier_mailer.send_admin_purchase_info.subject
  #
  def send_admin_purchase_info(order)
    @order = order
    @buyer = order.buyer
    @last_name = @buyer.last_name
    @first_name = @buyer.first_name
    @address_1 = @order.billing_address_1
    @address_2 = @order.billing_address_2
    @prefecture = @order.billing_prefecture
    mail to: "rasna@jyaasa.com", subject: '【Pick】注文が確定しました（自動送信メール)'
  end
end
