module ApplicationHelper

  def page_title(title)
    base_title = "raspas"
    title.empty? ? base_title : "#{base_title} { #{title}"
  end

  def page_description(description)
    base_description = "crie, colecione e compartilhe pensamentos"
    description.empty? ? base_description : description
  end

  def icon_tag(name)
    content_tag :i, nil, class: "icon-#{name}"
  end

  def icon_link_to(icon, target, *args)
    link_to "#{icon_tag icon}".html_safe, target, *args
  end
  
end
