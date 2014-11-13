class ChangeArticlePublishedToPublishedAt < ActiveRecord::Migration
  def change
    rename_column :articles, :published, :published_at
  end
end
