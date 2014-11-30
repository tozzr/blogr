class AddSessionToMetrixClick < ActiveRecord::Migration
  def change
    add_column :metrix_clicks, :session_id, :string
  end
end
