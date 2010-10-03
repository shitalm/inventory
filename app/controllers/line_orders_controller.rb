class LineOrdersController < ApplicationController
    active_scaffold :line_order do |config|
		config.list.columns = [:item, :itemCount, :price, :total_price]
		config.create.columns = [ :item, :itemCount, :price]
		config.update.columns = [ :item, :itemCount, :price]
		config.columns[:item].form_ui = :select
		config.columns[:price].label = "Unit Price"
		config.columns[:itemCount].label = "Item count"
		config.columns[:total_price].calculate = :sum
		config.columns[:itemCount].calculate = :sum
	end

end
