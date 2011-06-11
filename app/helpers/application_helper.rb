module ApplicationHelper
  
  def friendly_user_name(user)
    user.email.split("@")[0]
  end
  
end
