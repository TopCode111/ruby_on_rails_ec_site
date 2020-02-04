class UserDecorator < Draper::Decorator
  delegate_all

  def avatar
    if buyer?
      'buyer-default-avatar.png'
    elsif seller?
    	if profile.photo.present?
    		photo.url(:small)
      else
      	'buyer-default-avatar.png'
      end
    end
  end

  def name
    if buyer?
      full_name
    elsif seller?
      profile.name
    end
  end
end