class UserDecorator < Draper::Decorator 
  delegate_all

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end
  def avatar_image(size, id = "")
    if model.avatar.blank?
      h.image_tag 'default-user-avatar.jpg', :height => size, :width => size, :class => 'img-circle', :id => id    
    else
      h.image_tag model.avatar, :height => size, :width => size, :class => 'img-circle', :id => id  
    end
  end
  def profile_link
    h.link_to model.full_name, h.user_path(model) 
  end
  def follow_link
    if Following.where(:follower_id=>h.current_user, :user_id=>user).count==0 
      unless h.current_user.id == user.id 
        h.link_to 'Follow', h.user_follow_path(user.id), :remote=>true ,:class=>'btn btn-xs btn-success'
      end 
    else 
      h.link_to 'Unfollow', h.user_unfollow_path(user.id), :remote=>true ,:class=>'btn btn-xs btn-danger'
    end
  end
end
