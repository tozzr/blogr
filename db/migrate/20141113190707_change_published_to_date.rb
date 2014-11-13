class ChangePublishedToDate < ActiveRecord::Migration
  def change
    change_column :articles, :published, :date 
  end
end
