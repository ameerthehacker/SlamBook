class CommentsController < ApplicationController
    before_action :set_book_slam
    before_action :set_comment, :only => [ :edit, :update, :destroy ]
    before_action :authenticate_user!
    before_action :comment_owner, :only => [ :edit, :update ]
    before_action :comment_or_slam_owner => [ :destroy ]
    def index 
        @comments = @slam.comments.where(:reply_to => nil)
    end
    def create
        @comment = @slam.comments.build(get_params)
        @comment.user = current_user
        @comment.save
        respond_to do |format|
            format.js
        end
    end
    def edit
    end
    def update
        @comment.update(get_params)
        respond_to do |format|
            format.js
        end
    end
    def destroy
        @comment.destroy
        respond_to do |format|
            format.js
        end
    end
private
    def get_params
        params.require(:comment).permit(:comment, :reply_to)
    end
    def set_book_slam
        @book = Book.find(params[:book_id])
        @slam = @book.slams.find(params[:slam_id])     
    end
    def set_comment
        @comment = @slam.comments.find(params[:id])        
    end
    def comment_owner
        unless @comment.user == current_user
            flash[:danger] = "You are not authenticated to perform this action!"
            redirect_to book_slam_path(@book, @slam)
            false
        else
            true
        end
    end
    def comment_or_slam_owner
        if @comment.user == current_user || @comment.slam.user == current_user
            true
        else
            flash[:danger] = "You are not authenticated to perform this action!"
            redirect_to book_slam_path(@book, @slam)
            false
        end
    end
end
