class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.string :name
      t.numeric :price
      t.references :todo, foreign_key: true

      t.timestamps
    end
  end
end
