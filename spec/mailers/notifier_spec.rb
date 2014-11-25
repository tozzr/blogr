require 'rails_helper'
 
describe Notifier do
  describe 'notify_about' do
    before(:each) do
      @article = Article.new(title: 'foo')
      @comment = Comment.new(commenter: 'max', body: 'comment text')
      @mail = Notifier.notify_about(@article, @comment)
    end
 
    it 'renders the subject' do
      expect(@mail.subject).to eql('new comment on ' + @article.title)
    end
 
    it 'renders the receiver email' do
      expect(@mail.to).to eql(["mail@tozzr.com"])
    end
 
    it 'renders the sender email' do
      expect(@mail.from).to eql(['comments@tozzr.com'])
    end

    it 'works with nil params' do
      @mail = Notifier.notify_about(nil, nil)
      expect(@mail.body.encoded).to match('article')
      expect(@mail.body.encoded).to match('commenter')
      expect(@mail.body.encoded).to match('comment')
    end

    it 'assigns @article' do
      expect(@mail.body.encoded).to match(@article.title)
    end

    it 'assigns @commenter' do
      expect(@mail.body.encoded).to match(@comment.commenter)
    end

    it 'assigns @comment' do
      expect(@mail.body.encoded).to match(@comment.body)
    end
 
  end
end