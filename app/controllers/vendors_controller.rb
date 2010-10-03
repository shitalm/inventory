class VendorsController < ApplicationController
    active_scaffold :vendor do |config|
			config.columns = [:name, :address, :purchase_orders]
			config.list.columns = [:name, :address]
			config.nested.add_link("Purchase Orders", [:purchase_orders])
			config.nested.add_link("Expenses", [:expenses])
		end
end
