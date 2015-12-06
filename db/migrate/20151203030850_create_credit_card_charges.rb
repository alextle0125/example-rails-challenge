class CreateCreditCardCharges < ActiveRecord::Migration
  def change
    create_table :credit_card_charges do |t|
      t.float :amount
      t.string :unique_code
      t.boolean :paid
      t.boolean :refunded
      t.references :user, index: true
      t.references :company, index: true

      t.timestamps null: false
    end
    add_foreign_key :credit_card_charges, :users
    add_foreign_key :credit_card_charges, :companies
  end
end
