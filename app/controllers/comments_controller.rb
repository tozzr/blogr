class CommentsController < ApplicationController
  #before_filter :check_authorization

  def create
    @article = Article.find(params[:article_id])
    @comment = @article.comments.create!(comment_params)
    redirect_to slug_path(@article.slug), notice: 'comment was successfully saved.'  
  end
  
  rescue_from ActiveRecord::RecordInvalid do
    redirect_to slug_path(@article.slug), notice: 'comment was not saved.'
  end

  private
    def comment_params
      params.require(:comment).permit(:commenter, :body)
    end

end
