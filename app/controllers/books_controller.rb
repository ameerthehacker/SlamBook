class BooksController < ApplicationController
    before_action :set_book, :only => [:edit, :update, :destroy]
    before_action :authenticate_user!, :except => [ :index ]

    def index
        @books = current_user.books.all.order('created_at DESC')
    end
    def new 
        @book = Book.new
        @book.questions.build
    end
    def create
        @book = Book.new(get_params)
        @book.user = current_user
        if @book.save 
            news_feed = NewsFeed.new({ :user => current_user, :book => @book, :action => 'NEW_BOOK' })
            news_feed.save
            redirect_to books_path
        else
            render :new
        end
    end
    def edit
    end
    def update
        if @book.update(get_params)
            news_feed = NewsFeed.new({ :user => current_user, :book => @book, :action => 'UPDATE_BOOK' })
            news_feed.save
            redirect_to books_path            
        else
            render :edit
        end
    end
    def destroy
        @book.destroy
        redirect_to books_path
    end
    
private
    def get_params
        params.require(:book).permit(:title, :description, :questions_attributes => [ :id, :question, :_destroy ])
    end
    def set_book
        @book = Book.find(params[:id])
    end
end
