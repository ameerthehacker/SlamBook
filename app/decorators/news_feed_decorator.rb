class NewsFeedDecorator < Draper::Decorator
  delegate_all

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end
  def book_header(heading)
    h.content_tag :h4, :class => 'page-header' do
      model.user.decorate.avatar_image(50) + ' ' + h.link_to(model.user.full_name, h.user_path(model.user)) + ' ' + heading
    end
  end
  def slam_header(heading)
    if model.slam.book.user == h.current_user
      book_owner = "You "
      if model.slam.privacy == 'PUBLIC'
        book_owner += "publicly"
      elsif model.slam.privacy == 'PRIVATE'
        book_owner += "privately"        
      end
    else
      book_owner = h.link_to(model.slam.book.user.full_name, h.user_path(model.slam.book.user))
    end
    h.content_tag :h4, :class => 'page-header' do
      model.user.decorate.avatar_image(50) + ' ' + h.link_to(model.user.full_name, h.user_path(model.user)) + ' ' + heading + ' ' + model.slam.book.user.decorate.avatar_image(50) + ' ' + book_owner
    end
  end
end
