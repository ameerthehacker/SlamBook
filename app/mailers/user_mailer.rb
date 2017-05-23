class UserMailer < ApplicationMailer
    def follow(user, follower)
        @user = user
        @follower = follower
        mail :to => user.email, :subject => "#{follower.full_name} followed you"
    end
end
