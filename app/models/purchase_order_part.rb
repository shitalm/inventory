require 'pp'
class PurchaseOrderPart < ActiveRecord::Base

	validate :validate_part
	validates_numericality_of :delivered, :only_integer => true, :greater_than_or_equal_to => 0 

  belongs_to :purchase_order
  belongs_to :part

	def to_label
		" delivery count for #{part.name} purchased = #{purchased} "
	end

	def pretty_print(pp)
		puts "#{part.name} purchased=#{purchased} delivered=#{delivered}"
	end

	def validate_part
		errors.add(:delivered, "Delivered count (#{delivered}) can not be greater than purchase count (#{purchased})") if delivered > purchased
	end

end
