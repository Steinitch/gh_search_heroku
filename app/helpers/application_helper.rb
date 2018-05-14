module ApplicationHelper

  def avatar_link(image_url, size, destination_url )
    link_to(image_tag(image_url, size: size), destination_url, target: '_blank')
  end

end
