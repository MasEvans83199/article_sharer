class CommentsController < ApplicationController
    before_action :set_comment, only: [:edit, :update, :destroy]
    before_action :authenticate_user!
  
    def create
      @article = Article.find(params[:article_id])
      @comment = @article.comments.build(comment_params)
      @comment.user = current_user
  
      if @comment.save
        redirect_to @article, notice: 'Comment was successfully added.'
      else
        redirect_to @article, alert: 'Error adding comment.'
      end
    end

    def edit
    end
  
    def update
      authorize @comment
      if @comment.update(comment_params)
        redirect_to @comment.article, notice: 'Comment was successfully updated.'
      else
        render :edit
      end
    end
  
    def destroy
      authorize @comment
      if @comment.destroy
        flash[:notice] = "Comment deleted successfully."
        redirect_to article_path(@comment.article)
      else
        flash[:alert] = "Failed to delete the comment."
        redirect_to article_path(@comment.article)
      end
    end
  
    private
    
    def set_comment
      @comment = Comment.find_by(id: params[:id])
      unless @comment
        redirect_to root_path, alert: "Comment not found."
        return
      end
    end
    
    def comment_params
      params.require(:comment).permit(:body)
    end
  end
  