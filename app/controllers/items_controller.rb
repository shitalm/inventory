class ItemsController < ApplicationController
	active_scaffold :item do |config|
		config.columns = [:name, :description, :mrp, :parts]
		config.columns[:mrp].label = 'Max Retail Price'
	end 
end
