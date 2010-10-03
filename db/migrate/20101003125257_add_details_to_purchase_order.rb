class AddDetailsToPurchaseOrder < ActiveRecord::Migration
  def self.up
    add_column :purchase_orders, :details, :text
  end

  def self.down
    remove_column :purchase_orders, :details
  end
end
