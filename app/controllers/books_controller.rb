class BooksController < ApplicationController
    before_action :set_book, :only => [:edit, :update, :destroy]

    def index
    end
    def new 
        @book = Book.new
        @book.questions.build
    end
    def create
        @book = Book.new(get_params)
        if @book.save 
            redirect_to books_path
        else
            render :new
        end
    end
    def edit
    end
    def update
        if @book.update(get_params)
            redirect_to books_path            
        else
            render :edit
        end
    end

private
    def get_params
        params.require(:book).permit(:title, :description, :questions_attributes => [:id, :question, :_destroy ])
    end
    def set_book
        @book = Book.find(params[:id])
    end
end
