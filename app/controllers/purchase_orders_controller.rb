class PurchaseOrdersController < ApplicationController
		#layout "application"
    active_scaffold :purchase_order do |config|
		config.columns = [:vendor, :description, :purchaseDate, :line_orders, :price, :payments, :paid]
		config.list.columns = [:vendor, :description, :purchaseDate, :price, :paid, :delivered]
		config.show.columns = [:vendor, :description, :purchaseDate, :price, :paid, :delivered]
		config.nested.add_link("Line Items", [:line_orders])
		config.nested.add_link("Parts", [:purchase_order_parts])
		config.nested.add_link("Payments", [:payments])
		config.create.columns = [:vendor, :description, :purchaseDate, :line_orders]
		config.columns[:vendor].form_ui = :select
		config.columns[:price].calculate = :sum
	end
end
