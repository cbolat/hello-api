class CreateCustomers < ActiveRecord::Migration[5.2]
  def change
    create_table :customers do |t|
      t.string :name
      t.boolean :done
      t.references :todo, foreign_key: true

      t.timestamps
    end
  end
end
