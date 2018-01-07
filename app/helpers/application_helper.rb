module ApplicationHelper
  def icon_link_to(destination, btn_style, icon, options = {})
    icon_link_to_defaults.reverse_merge(options)
    a_classes = "btn btn-xs btn-#{btn_style}"
    content_tag :a, href: destination, class: a_classes, method: options[:method], title: options[:title], data: options[:data], target: options[:target] do
      concat(content_tag :i, '', class: "fa fa-#{icon}") if icon
    end
  end

  def icon_link_to_defaults
    {
      title: '',
      data: '',
      target: '_self'
    }
  end
end
