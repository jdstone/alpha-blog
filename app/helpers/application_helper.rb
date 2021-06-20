module ApplicationHelper
  def gravatar_for(user, options = {})
    email_address = user.email.downcase
    size = options[:size] || 100
    css = options[:css] || "rounded shadow mx-auto d-block"
    hash = Digest::MD5.hexdigest(email_address)
    image_src = "https://www.gravatar.com/avatar/#{hash}?s=#{size}"
    image_tag(image_src, alt: "#{user.firstname} #{user.lastname}", class: css)
  end

  def bootstrap_flash_class_for flash_type
    case flash_type
      when "alert"
        "alert-danger"
      when "notice"
        "alert-success"
      else
        "alert-info"
    end
  end
end
