class BookCommentsController < ApplicationController
  
  def create
    book = Book.find(params[:book_id])
    @comment = BookComment.new(book_comment_params)
    @comment.user_id = current_user.id
    # comment = current_user.post_comments.new(post_comment_params) <---5.6行目の省略形
    @comment.book_id = book.id
    @comment.save
  end
  
  def destroy
    @comment = BookComment.find(params[:id])
    @comment.destroy
  end
  
  private
  
  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end
  
end
