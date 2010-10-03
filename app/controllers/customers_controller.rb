class CustomersController < ApplicationController
    active_scaffold :customer do |config|
			config.columns = [:name, :address, :sale_orders]
			config.list.columns = [:name, :address]
			config.create.columns = [:name, :address]
			config.nested.add_link("Expenses", [:expenses])
			config.nested.add_link("Sale orders", [:sale_orders])
		end
end
