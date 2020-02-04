class PaymentInterface
  def initialize(user, stripe_handler, token = nil)
    @user = user
    @stripe_handler = stripe_handler
    @token = token
  end

  def stripe_retrieve_card(stripe_customer_id, stripe_card_id)
    @stripe_handler.retrieve_card(stripe_customer_id, stripe_card_id)
  end

  def stripe_create_customer
    @stripe_handler.create_customer(@user.email, @token)
  end

  def stripe_retrieve_customer(customer_id)
    @stripe_handler.retrieve_customer(customer_id)
  end

  def create_card(stripe_customer_id, token)
    @stripe_handler.create_card(stripe_customer_id, token)
  end

  def create_charge(stripe_customer_id, amount)
    @stripe_handler.create_charge(stripe_customer_id, amount)
  end
end
