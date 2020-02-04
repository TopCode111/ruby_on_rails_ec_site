class CustomFailure < Devise::FailureApp
  def redirect_url
    if request.referer.present? && request.referer.split('/')[4] == 'checkout'
      checkout_path(id: request.referer.split('/')[5]) 
    else
      super
    end
  end

  def respond
    if http_auth?
      http_auth
    else
      redirect
    end
  end
end