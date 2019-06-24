class CreateLeafs < ActiveRecord::Migration[5.2]
  def change
    create_table :leafs do |t|
      t.string :title
      t.string :created_by
      t.references :todo, foreign_key: true

      t.timestamps
    end
  end
end
