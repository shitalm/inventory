class SaleOrderLinesController < ApplicationController
    active_scaffold :sale_order_line do |config|
    	config.columns = [:item, :mrp, :discount, :item_count, :unit_price, :total_price]
			config.columns[:item].update_column = :mrp
    	config.list.columns = [:item, :item_count, :unit_price, :total_price]
    	config.create.columns = [ :item, :mrp, :item_count, :discount]
			config.columns[:discount].label = 'Discount (Rs)'
			config.columns[:mrp].options = { :disabled => 'true'} 
    	config.update.columns = [ :item, :item_count, :unit_price] 
    	config.columns[:item].form_ui = :select
    	config.columns[:total_price].calculate = :sum
    	config.columns[:item_count].calculate = :sum
		end
end
