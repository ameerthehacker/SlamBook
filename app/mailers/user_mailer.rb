class UserMailer < ApplicationMailer
    def follow
        mail :to => 'ameerjhanprof@gmail.com'
    end
end
