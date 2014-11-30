class CreateMetrixClicks < ActiveRecord::Migration
  def change
    create_table :metrix_clicks do |t|
      t.string :location
      t.integer :mouse_x
      t.integer :mouse_y
      t.integer :document_w
      t.integer :document_h
      t.integer :screen_w
      t.integer :screen_h

      t.timestamps
    end
  end
end
