class AddDetailsToSaleOrder < ActiveRecord::Migration
  def self.up
    add_column :sale_orders, :details, :text
  end

  def self.down
    remove_column :sale_orders, :details
  end
end
