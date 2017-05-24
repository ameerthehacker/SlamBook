class SlamsController < ApplicationController
    before_action :set_book
    before_action :set_slam, :only => [ :edit, :update, :show, :destroy ]
    before_action :authenticate_user!, :except => [ :index ]
    before_action :slam_owner, :only => [ :edit, :update ]
    before_action :slam_or_book_owner, :only => [ :destroy ]    
    
    def index 
        @slams = @book.slams.paginate(:page => params[:page], :per_page => 5).order('created_at DESC')
    end
    def new
        if @book.user == current_user
            flash[:danger]="You can't slam yourself!'"
            redirect_to home_path
        end
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
            flash[:success] = "Your slam was successful!"
            news_feed = NewsFeed.new({ :user => current_user, :slam => @slam, :action => 'NEW_SLAM' })
            news_feed.save
            User.delay.notify_user(@book.user, "#{current_user.full_name} slammed on your slambook #{@book.title}", 
            book_slam_path(@book, @slam))
            User.delay.email_new_slam(current_user, @slam)
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
            flash[:success] = "Your slam was updated!"            
            news_feed = NewsFeed.new({ :user => current_user, :slam => @slam, :action => 'UPDATE_SLAM' })
            news_feed.save
            redirect_to book_slams_path(@book)
        else
            render :edit
        end
    end
    def destroy
        @slam.destroy
        flash[:success] = "Your slam was deleted!"        
        redirect_to book_slams_path(@book)        
    end
private
    def slam_owner
        if @slam.user == current_user
            true
        else
            flash[:danger] = "You are not authenticated to perform this action!"
            redirect_to book_slams_path(@book)
            false
        end
    end
    def slam_or_book_owner
        if @slam.user == current_user || @slam.book.user == current_user
            true
        else
            flash[:danger] = "You are not authenticated to perform this action!"
            redirect_to book_slams_path(@book)
            false
        end
    end
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
