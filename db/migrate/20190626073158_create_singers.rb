class CreateSingers < ActiveRecord::Migration[5.0]
  def change
    create_table :singers do |t|
      t.string :name
      t.string :created_by

      t.timestamps
    end
  end
end
