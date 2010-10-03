class StockController < ApplicationController
	#layout "application"
  def index
		calculate_item_inventory
	end

	def calculate_item_inventory
		@items = Item.find(:all)
		@inventory = Hash.new
		@parts_inventory = Hash.new
		@items.each do |item|
			purchased = LineOrder.sum('itemCount', :conditions => "item_id = #{item.id}")
			sold = SaleOrderLine.sum('item_count', :conditions => "item_id = #{item.id}")
			item_inventory = {:item => item, :purchased => purchased, :sold => sold}
		
			#puts "inventory for #{item.name} is " 
			#item_inventory.each_pair {|key, value| puts "#{key} = #{value}" }
			@inventory[item.id] = item_inventory
		end

		#calculate parts inventory
		parts = Part.find(:all)
		parts.each do |part|
			purchased = PurchaseOrderPart.sum('purchased', :conditions => "part_id = #{part.id}")
			vendor_delivered = PurchaseOrderPart.sum('delivered', :conditions => "part_id = #{part.id}")
			sold = SaleOrderPart.sum('sold', :conditions => "part_id = #{part.id}")
			customer_delivered = SaleOrderPart.sum('delivered', :conditions => "part_id = #{part.id}")
			in_stock = vendor_delivered - customer_delivered
			further_expected = purchased - vendor_delivered
			customer_due = sold - customer_delivered
			if(customer_delivered > vendor_delivered) 
				status = { :type => "ERROR", :message => "Impossible!"}
			elsif(sold > purchased)
				status = {:type => "WARN", :message => "Need to place purchase order urgently"}
			elsif(customer_due > in_stock)
				status = {:type => "INFO", :message => "Waiting for vendor to deliver"}
			else
				status = {:type => "NORMAL", :message => ""}
			end 
			
			part_inventory = {:part => part, :purchased => purchased, :vendor_delivered => vendor_delivered, :sold => sold, :customer_delivered => customer_delivered, :in_stock => in_stock, :further_expected => further_expected, :customer_due => customer_due, :status => status}
			@parts_inventory[part.id] = part_inventory
		end

  end

end
