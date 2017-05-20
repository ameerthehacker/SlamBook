class UsersController < ApplicationController
    before_action :set_user, :except => [ :search ]
    
    def books
        @books = @user.books.all.order('created_at DESC')
    end
    def update_avatar
        current_user.avatar = params[:avatar]
        if current_user.avatar.blank?
            current_user.errors.add(:avatar, 'must be selected')
        else
            current_user.save
            flash[:success] = 'Avatar updated successfully'
        end 
        respond_to do | format | 
            format.js
        end
    end
    def remove_avatar
         current_user.avatar = nil
         current_user.save
         flash[:success] = 'Avatar removed successfully'
         respond_to do | format | 
            format.js
         end
    end
    def slams
        @slams = Slam.all.where(:user_id => current_user)
    end
    def following
        @user = User.find(params[:user_id])
        @followings = Following.where(:follower_id => @user.id)
    end
    def search
        @users=User.where('(users.first_name LIKE ? OR users.email LIKE ?) AND users.email <> ?', "#{params[:query]}%", "#{params[:query]}%", current_user.email)
    end
    def follow
        @user.followers<<current_user
        current_user.notify_user(@user, "#{current_user.full_name} followed you on theSlamBook, view slambooks to slam now!", user_books_path(current_user))
        respond_to do |format|
            format.js
        end
    end
    def unfollow
        @following=Following.where(:user_id => @user, :follower_id=>current_user)
        @following.delete_all
        respond_to do |format|
            format.js
        end
    end

private
    def set_user
        @user = User.find(params[:user_id])
    end
end
