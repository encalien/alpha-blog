module ApplicationHelper
  def gravatar_for(user, options = { size:80 })
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    size = options[:size]
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: user.username, class: "img-circle")
  end
  
  def flash_class(level)
    case level
        when "notice" then "alert alert-info"
        when "success" then "alert alert-success"
        when "danger" then "alert alert-error"
    end
  end
end
