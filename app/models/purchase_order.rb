require 'pp'
class PurchaseOrder < ActiveRecord::Base
  def to_label
    "#{description}"
  end

# define all associations
  belongs_to :vendor
  has_many :line_orders, :dependent => :destroy 
	has_many :purchase_order_parts, :dependent => :destroy 

	before_update :update_price, :update_parts
	#before_save :update_price, :update_parts

	def pretty_print(pp)
		puts self.inspect
		puts "#{description} (id=#{id}) has no line orders" if line_orders.empty?
		line_orders.each {|line| pp(line) }
		puts "#{description} (id=#{id}) has no order parts" if purchase_order_parts.empty?
		purchase_order_parts.each {|line| pp(line) }
	end

	def delivered
		if purchase_order_parts.all? {|part| part.delivered == part.purchased}
			flag = 'Yes'
		elsif purchase_order_parts.all? {|part| part.delivered == 0}
			flag = 'No'
		else
			flag = 'Partial'
		end
		return flag
	end

	def update_parts
		puts "========== entered PurchaseOrder::update_parts ================"
		pp(self)
		parts_purchase_count = Hash.new
		line_orders.each do |line|
			line.item.parts.each do |line_part|
				parts_purchase_count[line_part.id] = 0 if parts_purchase_count[line_part.id].nil?
				parts_purchase_count[line_part.id] += line.itemCount
			end
		end
		# some line order might have been deleted leaving orphan parts, remove corresponding parts
		purchase_order_parts.each do |part|
			part.destroy if parts_purchase_count[part.id].nil?
		end
		parts_purchase_count.each_pair do |part_id, count|
			puts "Part id #{part_id} purchase count = #{count}"
			p_part = PurchaseOrderPart.find(:first, :conditions => {:purchase_order_id => self.id, :part_id => part_id})
			p_part = self.purchase_order_parts.new(:purchase_order_id => self.id, :part_id => part_id, :purchased => 0, :delivered => 0) if p_part.nil?
			p_part.purchased = count
			p_part.save
		end

		puts "========== leaving PurchaseOrder::update_parts ================"
		pp(self)
	end

	def update_price
		puts "========== entered PurchaseOrder::update_price #{self.price} ================"
		pp(self)
		lines = self.line_orders
		self.price = 0
		lines.each do |line| 
			puts "price for line id #{line.id} is #{line.total_price}"
			self.price += line.total_price
		end
		puts "========== leaving PurchaseOrder::update_price #{self.price} ================"
		pp(self)
	end


end
