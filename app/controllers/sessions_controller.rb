class SessionsController < Devise::SessionsController

  def destroy
    purchase_order_id = session[:purchase_order_id] 
    super  
    session[:purchase_order_id] = purchase_order_id
  end
end