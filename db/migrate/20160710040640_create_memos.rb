class CreateMemos < ActiveRecord::Migration
  def change
    create_table :memos do |t|
      t.string :title
      t.string :description
      t.string :address
      t.float :latitude
      t.float :longitude
      t.integer :user_id

      t.timestamps
    end
  end
end
