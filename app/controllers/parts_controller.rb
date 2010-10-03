class PartsController < ApplicationController
	active_scaffold :part do |config|
		config.columns = [:name, :description, :item, :purchased, :vendor_delivered, :sold, :customer_delivered, :in_stock, :further_expected, :customer_due, :status_message]
		config.create.columns = [:name, :description, :item]
		config.update.columns = [:name, :description, :item]
	end
end
