class AddHoneyFieldToComment < ActiveRecord::Migration
  def change
    add_column :comments, :honey, :string
  end
end
