class SaleOrderLine < ActiveRecord::Base

	before_validation :set_defaults
#	before_create :update_unit_price
	before_save :update_total_price
	after_save :update_sale_order

	validate :sale_line_order_validations
	validates_numericality_of :delivered_count, :greater_than_or_equal_to => 0
	validates_numericality_of :unit_price, :greater_than_or_equal_to => 0.0, :on => "update"
	validates_numericality_of :item_count, :only_integer => true, :greater_than => 0 

  belongs_to :sale_order
  belongs_to :item

  def to_label
    "#{item.name}-#{item_count}"
  end

	def delivered
		flag = 'No'
		if delivered_count == 0
			flag = 'No'
		elsif delivered_count < item_count
			flag = 'Partial'
		else
			flag = 'Yes'
		end
		return flag
	end

	def discount
		return 0
	end

	def mrp
		return item.mrp if !item.nil?
	end

	def mrp=(mrp)
	end


	def set_defaults
		puts "delivered_count for line order id #{id} is " + delivered_count.to_s
		puts "self delivered_count is " + self.delivered_count.to_s
		if (self.delivered_count == nil)
			puts "delivered_count is nil"
			self.delivered_count = 0
		end
	end

	def discount=(amount)
		amount = amount.to_i
		puts "update_unit_price item #{item.name} MRP = #{item.mrp} discount = #{amount}"
		self.unit_price = item.mrp - amount
		#puts "update_unit_price item #{item.name} unit price = #{self.unit_price}"
	end

	def update_total_price
		puts "==================== before LineOrders::update_total_price for line #{id} = #{total_price} ============"
		self.total_price = self.item_count * self.unit_price
		puts "==================== LineOrders::update_total_price for line #{id} = #{total_price} ============"
	end

	def update_sale_order
		self.sale_order.save
	end
		

	def sale_line_order_validations
		puts "sale_line_order_validations #{self.inspect}"
		errors.add(:delivered_count, "can't be greater than item count") if 
			delivered_count > item_count
		errors.add(:discount, "can't be greater than Max Retail Price") if
			discount.to_i > item.mrp.to_i
	end

end
