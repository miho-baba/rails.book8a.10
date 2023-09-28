class CreateFavorites < ActiveRecord::Migration[6.1]
  def change
    create_table :favorites do |t|
      t.integer :user_id, null: false, foreign_key: true
      t.integer :book_id, null: false, foreign_key: true

      t.timestamps
    end
  end
end
