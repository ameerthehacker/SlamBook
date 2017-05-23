class UserMailer < ApplicationMailer
    def follow(user, follower)
        @user = user
        @follower = follower
        mail :to => user.email, :subject => "#{follower.full_name} followed you"
    end
    def new_book(user, follower, book)
        @user = user
        @follower = follower
        @book = book
        mail :to => follower.email, :subject => "#{user.full_name} has created a new slambook"
    end
    def update_book(user, follower, book)
        @user = user
        @follower = follower
        @book = book
        mail :to => follower.email, :subject => "#{user.full_name} has updated a  slambook"
    end
    def new_slam(user, follower, slam)
        @user = user
        @follower = follower
        @slam = slam
        if @slam.book.user == @follower
            subject = "Wow! #{user.full_name} slammed you"
        else
            subject = "#{user.full_name} slammed #{@slam.book.user.full_name}"            
        end
        mail :to => follower.email, :subject => subject
    end
end
