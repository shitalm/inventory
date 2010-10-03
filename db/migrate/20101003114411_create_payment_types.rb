class CreatePaymentTypes < ActiveRecord::Migration
  def self.up
    create_table :payment_types do |t|
      t.string :name

      t.timestamps
    end
		PaymentType.create([{:name => "Cash"}, {:name => "Cheque"}])
  end

  def self.down
    drop_table :payment_types
  end
end
