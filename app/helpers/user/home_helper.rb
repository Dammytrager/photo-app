module User::HomeHelper
  def sidebar_link_to(label, link, **args)
    default_class = 'list-group-item list-group-item-action'
    default_class += ' bg-light' if link == request.path
    return link_to label, link, class: default_class, **args.except(:class)
  end
end
