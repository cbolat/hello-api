class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :name
      t.boolean :done
      t.references :note, foreign_key: true

      t.timestamps
    end
  end
end
