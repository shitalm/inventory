class ItemsController < ApplicationController
	active_scaffold :item do |config|
		config.columns = [:name, :description, :mrp, :total_purchased, :total_sold, :in_stock, :parts]
		config.create.columns = [:name, :description, :mrp, :parts]
		config.update.columns = [:name, :description, :mrp, :parts]
		config.columns[:mrp].label = 'Max Retail Price'
	end 
end
