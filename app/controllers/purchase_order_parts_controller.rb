class PurchaseOrderPartsController < ApplicationController
	active_scaffold :purchase_order_parts do |config|
		config.columns = [:part, :purchased, :delivered]
		config.update.link = false
		config.delete.link = false
		config.create.link = false
		config.show.link = false
		config.columns[:delivered].inplace_edit = true
	end
end
