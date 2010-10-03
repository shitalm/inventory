class Part < ActiveRecord::Base
  has_and_belongs_to_many :item

	def purchased
    PurchaseOrderPart.sum('purchased', :conditions => "part_id = #{id}")
	end

	def vendor_delivered 
		PurchaseOrderPart.sum('delivered', :conditions => "part_id = #{id}")
	end

	def sold 
		SaleOrderPart.sum('sold', :conditions => "part_id = #{id}")
	end

	def customer_delivered 
		SaleOrderPart.sum('delivered', :conditions => "part_id = #{id}")
	end

	def in_stock 
		vendor_delivered - customer_delivered
	end

	def further_expected 
		purchased - vendor_delivered
	end

	def customer_due 
		sold - customer_delivered
	end

	def status
			if(customer_delivered > vendor_delivered)
        status = { :type => "ERROR", :message => "Impossible!"}
      elsif(sold > purchased)
        status = {:type => "WARN", :message => "Need to place purchase order urgently"}
      elsif(customer_due > in_stock)
        status = {:type => "INFO", :message => "Waiting for vendor to deliver"}
      else
        status = {:type => "NORMAL", :message => ""}
      end
	end

	def status_message
		return status[:message]
	end

end
