class AddSpamFlagToArticleComments < ActiveRecord::Migration
  def change
    add_column :comments, :is_spam, :boolean, default: false
  end
end
