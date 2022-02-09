class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.datetime :order_date
      t.integer :status, default: 0
      t.string :order_address
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
