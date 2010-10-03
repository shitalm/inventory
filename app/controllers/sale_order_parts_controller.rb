class SaleOrderPartsController < ApplicationController
	  active_scaffold :sale_order_parts do |config|
    config.columns = [:part, :sold, :delivered]
    config.update.link = false
    config.delete.link = false
    config.create.link = false
    config.show.link = false
    config.columns[:delivered].inplace_edit = true
  end
end
