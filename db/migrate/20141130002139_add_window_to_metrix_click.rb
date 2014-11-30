class AddWindowToMetrixClick < ActiveRecord::Migration
  def change
    add_column :metrix_clicks, :window_w, :integer 
    add_column :metrix_clicks, :window_h, :integer
  end
end
