require 'pp'
class LineOrder < ActiveRecord::Base

#	before_validation :set_defaults
	before_save :update_price
	after_save :update_purchase_order
	after_destroy :update_purchase_order 

# validate :line_order_validations
	#validates_numericality_of :deliveredCount, :greater_than_or_equal_to => 0
#	validates_numericality_of :total_price, :greater_than_or_equal_to => 0.0
	validates_numericality_of :price, :greater_than_or_equal_to => 0.0
	validates_numericality_of :itemCount, :only_integer => true, :greater_than => 0 

  belongs_to :purchase_order
  belongs_to :item

  def to_label
    "#{item.name}-#{itemCount}"
  end

	def pretty_print(pp)
		puts "#{item.name} count=#{itemCount} delivered=#{deliveredCount} unit-price=#{price} total-price=#{total_price}"
	end

	def delivered
		flag = 'No'
		if deliveredCount == 0
			flag = 'No'
		elsif deliveredCount < itemCount
			flag = 'Partial'
		else
			flag = 'Yes'
		end
		return flag
	end


	def set_defaults
	end

	def update_price
		puts "==================== before LineOrders::update_price for line #{id} = #{total_price} ============"
		self.total_price = self.itemCount * self.price
		puts "==================== LineOrders::update_price for line #{id} = #{total_price} ============"
	end

	def update_purchase_order
		self.purchase_order.save
	end
		

	def line_order_validations
		errors.add(:deliveredCount, "can't be greater than item count") if deliveredCount > itemCount
	end

end
