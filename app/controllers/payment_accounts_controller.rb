class PaymentAccountsController < ApplicationController
  before_action :authenticate_user!
  def new; end

  def create
    create_update_payment_account('', params[:stripeToken])
    if request.referer.present? && request.referer.split('/').include?('cart')
      redirect_to cart_path
    else
      redirect_to address_payments_path
    end
  end

  def edit
    @payment = PaymentAccount.find(params[:id])
  end

  def update
    @payment = PaymentAccount.find(params[:id])
    create_update_payment_account(@payment, params[:stripeToken])
    if request.referer.present? && request.referer.split('/').include?('cart')
      redirect_to cart_path
    else
      redirect_to address_payments_path
    end
  end

  private

  def create_update_payment_account(payment, stripe_token)
    stripe_handler = StripeHandler.new
    payment_interface = PaymentInterface.new(current_user, stripe_handler, stripe_token)
    if payment.present? && payment.stripe_customer_id.present?
      customer = payment_interface.stripe_retrieve_customer(payment.stripe_customer_id)
      if customer
        card = payment_interface.create_card(customer.id, stripe_token)
        payment.update(stripe_customer_id: customer.id,
                       card_no: card.last4,
                       card_type: card.brand,
                       exp_month: card.exp_month,
                       exp_year: card.exp_year)
      else
        customer = payment_interface.stripe_create_customer
        payment.update(card_no: customer.sources.data.first.last4,
                     card_type: customer.sources.data.first.brand,
                     stripe_customer_id: customer.id,
                     exp_month: customer.sources.data.first.exp_month,
                     exp_year: customer.sources.data.first.exp_year)
      end
    else
      customer = payment_interface.stripe_create_customer
      current_user.create_payment_account(card_no: customer.sources.data.first.last4,
                                          card_type: customer.sources.data.first.brand,
                                          stripe_customer_id: customer.id,
                                          exp_month: customer.sources.data.first.exp_month,
                                          exp_year: customer.sources.data.first.exp_year)
    end
  end
end
