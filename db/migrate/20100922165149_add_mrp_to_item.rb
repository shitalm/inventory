class AddMrpToItem < ActiveRecord::Migration
  def self.up
    add_column :items, :mrp, :float
  end

  def self.down
    remove_column :items, :mrp
  end
end
