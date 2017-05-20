class SlamsController < ApplicationController
    before_action :set_book
    before_action :set_slam, :only => [ :edit, :update, :show, :destroy ]
    before_action :authenticate_user!, :except => [ :index ]
    
    def index 
        @slams = @book.slams.all.order('created_at DESC')
    end
    def new
        @slam = @book.slams.build
        @slam.privacy = 'PRIVATE'
        @book.questions.each do |question|
            answer = @slam.answers.build
            answer.question = question.question
        end
    end
    def create
        @slam = @book.slams.build(get_params)
        @slam.user = current_user
        if @slam.save
            news_feed = NewsFeed.new({ :user => current_user, :slam => @slam, :action => 'NEW_SLAM' })
            news_feed.save
            current_user.notify_user(@book.user, "#{current_user.full_name} slammed on your slambook #{@book.title}", book_slam_path(@book, @slam))
            redirect_to book_slams_path(@book)
        else
            render :new
        end
    end
    def show
    end
    def edit
    end
    def update
        if @slam.update(get_params)
            news_feed = NewsFeed.new({ :user => current_user, :slam => @slam, :action => 'UPDATE_SLAM' })
            news_feed.save
            redirect_to book_slams_path(@book)
        else
            render :edit
        end
    end
    def destroy
        @slam.destroy
        redirect_to book_slams_path(@book)        
    end
private
    def set_book
        @book = Book.find(params[:book_id])
    end
    def set_slam
        @slam = Slam.find(params[:id])
    end
    def get_params
        params.require(:slam).permit(:privacy, :answers_attributes => [:id, :question, :answer])
    end
end
