class CreateTransactions < ActiveRecord::Migration[5.0]
  def change
    create_table :transactions do |t|
      t.text :transaction_description
      t.decimal :amount_spent
      t.string :transaction_type
      t.belongs_to :user, index: true
      t.timestamps
    end
  end
end
