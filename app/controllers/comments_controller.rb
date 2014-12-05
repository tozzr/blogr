class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :destroy]
  
  class CommentParams
    def self.build params
      params.require(:comment)[:is_spam] = params.require(:comment)[:honey].to_s != ''
      params.require(:comment).permit(:commenter, :body, :honey, :is_spam)  
    end
  end

  def create
    @article = Article.find(params[:article_id])
    @comment = @article.comments.create!(CommentParams.build(params))
    Notifier.notify_about(@article, @comment).deliver
    redirect_to slug_path(@article.slug), notice: 'comment was successfully saved.'  
  end
  
  rescue_from ActiveRecord::RecordInvalid do
    redirect_to slug_path(@article.slug), notice: 'comment was not saved.'
  end

  def index
    @article = Article.find(params[:article_id])
    @comments = @article.comments
  end

  def show
  end

  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to article_comments_url, notice: 'Comment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_comment
      begin
        @comment = Comment.find(params[:id])
      rescue Exception => e
        respond_to do |format|
          format.html { redirect_to article_comments_url }
          format.json { head :not_found }
        end
      end
    end
end
