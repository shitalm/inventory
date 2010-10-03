class SaleOrdersController < ApplicationController
    active_scaffold :sale_order do |config|
		config.label = 'Sale Orders'
    config.columns = [:customer, :name, :sale_date, :sale_order_lines, :price, :payments]
		config.list.columns = [:customer, :name, :sale_date, :price, :paid, :delivered]
		config.show.columns = [:customer, :name, :sale_date, :price, :paid, :delivered]
    config.nested.add_link("Line Items", [:sale_order_lines])
    config.nested.add_link("Parts", [:sale_order_parts])
		config.nested.add_link("Payments", [:payments])
    config.create.columns = [:customer, :name, :sale_date, :sale_order_lines]
		config.columns[:name].label = 'Order description'
  end
end
