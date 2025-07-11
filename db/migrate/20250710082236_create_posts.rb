class CreatePosts < ActiveRecord::Migration[8.0]
  def change
    create_table :posts do |t|
      t.references :group, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.string :title
      t.text :body
      t.integer :min_age
      t.integer :max_age

      t.timestamps
    end
  end
end
