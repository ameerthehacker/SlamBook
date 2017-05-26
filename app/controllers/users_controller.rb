class UsersController < ApplicationController
    before_action :set_user, :except => [ :search ]
    
    def books
        @books = @user.books.paginate(:page => params[:page], :per_page => 5).order('created_at DESC')
    end
    def book
        @book = Book.find(params[:book_id])
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
        @slams = Slam.where(:user_id => @user).paginate(:page => params[:page], :per_page => 5).order('created_at DESC')
    end
    def following
        @user = User.find(params[:user_id])
        @followings = Following.paginate(:page => params[:page], :per_page => 10).where(:follower_id => @user.id)
    end
    def followers
        @user = User.find(params[:user_id])
        @followers = @user.followers.paginate(:page => params[:page], :per_page => 10)
    end
    def search
        @users=User.where('(lower(users.first_name) LIKE ? OR lower(users.email) LIKE ?) AND users.email <> ?', "#{params[:query].downcase}%", "#{params[:query]}%", current_user.email.downcase).paginate(:page => params[:page], :per_page => 10).order("created_at DESC")
    end
    def follow
        if @user.followers.where(:id => current_user).count == 0
            @user.followers<<current_user
            User.delay.notify_user(@user, "#{current_user.full_name} followed you on theSlamBook, view slambooks to slam 
            now!", user_books_path(current_user))
            User.delay.email_followed(@user, current_user)        
        end
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
