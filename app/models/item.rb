class Item < ActiveRecord::Base
	has_and_belongs_to_many :parts

	def total_purchased
		LineOrder.sum('itemCount', :conditions => "item_id = #{id}")
	end

	def total_sold
		SaleOrderLine.sum('item_count', :conditions => "item_id = #{id}")
	end

	def in_stock
		total_purchased - total_sold
	end

end
