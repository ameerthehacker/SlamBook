class BooksController < ApplicationController
    before_action :set_book, :only => [ :edit, :update, :destroy ]
    before_action :authenticate_user!

    def index
        @books = current_user.books.paginate(:page => params[:page], :per_page => 5).order('created_at DESC')
    end
    def new 
        @book = Book.new
        @book.questions.build
    end
    def create
        @book = Book.new(get_params)
        @book.user = current_user
        if @book.save 
            flash[:success] = "Your slambook was created!"
            news_feed = NewsFeed.new({ :user => current_user, :book => @book, :action => 'NEW_BOOK' })
            news_feed.save            
            User.delay.notify_followers(current_user, "#{current_user.full_name} created a new slambook #{@book.title}, slam now!", new_book_slam_path(@book))
            User.email_new_book(current_user, @book)
            redirect_to books_path
        else
            render :new
        end
    end
    def edit
    end
    def update
        if @book.update(get_params)
            flash[:success] = "Your slambook was updated!"            
            news_feed = NewsFeed.new({ :user => current_user, :book => @book, :action => 'UPDATE_BOOK' })
            news_feed.save
            User.delay.notify_followers(current_user, "#{current_user.full_name} updated the slambook #{@book.title}, slam now!", new_book_slam_path(@book))
            User.email_update_book(current_user, @book)
            redirect_to books_path            
        else
            render :edit
        end
    end
    def destroy
        @book.destroy
        flash[:success] = "Your slambook was deleted!"        
        redirect_to books_path
    end
    
private
    def get_params
        params.require(:book).permit(:title, :description, :questions_attributes => [ :id, :question, :_destroy ])
    end
    def set_book
        @book = current_user.books.find(params[:id])
    end
end
