class SlamsController < ApplicationController
    before_action :set_book
    before_action :set_slam, :only => [ :edit,:update,:destroy ]

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
        if @slam.save
            redirect_to books_path
        else
            render :new
        end
    end
    def edit
    end
    def update
        if @slam.update(get_params)
            redirect_to books_path
        else
            render :edit
        end
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
