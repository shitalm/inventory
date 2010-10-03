class CreatePayments < ActiveRecord::Migration
  def self.up
    create_table :payments do |t|
      t.references :payable, :polymorphic => true 
      t.references :payment_type
      t.float :amount
      t.date :date
      t.text :details

      t.timestamps
    end
  end

  def self.down
    drop_table :payments
  end
end
