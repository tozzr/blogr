class Notifier < ActionMailer::Base
  default from: 'mail@tozzr.com'
 
  def notify_about(article, comment)
    @article = article ? article.title : 'article'
    @commenter = comment ? comment.commenter : 'commenter'
    @comment = comment ? comment.body : 'comment'
    mail to: 'mail@tozzr.com', subject: 'new comment on ' + @article
  end
end
