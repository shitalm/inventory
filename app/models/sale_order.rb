class SaleOrder < ActiveRecord::Base
  belongs_to :customer
	has_many :sale_order_lines, :dependent => :destroy 
	has_many :sale_order_parts, :dependent => :destroy

  before_update :update_price, :update_parts

  def pretty_print(pp)
    puts self.inspect
    puts "#{name} (id=#{id}) has no line orders" if sale_order_lines.empty?
    sale_order_lines.each {|line| pp(line) }
    puts "#{name} (id=#{id}) has no order parts" if sale_order_lines.empty?
    sale_order_parts.each {|line| pp(line) }
  end

  def delivered
    if sale_order_parts.all? {|part| part.delivered == part.sold}
      flag = 'Yes'
    elsif sale_order_parts.all? {|part| part.delivered == 0}
      flag = 'No'
    else
      flag = 'Partial'
    end
    return flag
  end

  def update_price
    puts "========== before SaleOrder::update_price #{self.price} ================"
		pp(self)
    lines = self.sale_order_lines
    self.price = 0
    lines.each do |line|
      puts "price for line id #{line.id} is #{line.total_price}"
      self.price += line.total_price
    end
    puts "========== after SaleOrder::update_price #{self.price} ================"
		pp(self)
  end

  def update_parts
    puts "========== entered SaleOrder::update_parts ================"
    pp(self)
    parts_sale_count = Hash.new
    sale_order_lines.each do |line|
      line.item.parts.each do |line_part|
        parts_sale_count[line_part.id] = 0 if parts_sale_count[line_part.id].nil?
        parts_sale_count[line_part.id] += line.item_count
      end
    end
    # some line order might have been deleted leaving orphan parts, remove corresponding parts
    sale_order_parts.each do |part|
      part.destroy if parts_sale_count[part.id].nil?
    end
    parts_sale_count.each_pair do |part_id, count|
      puts "Part id #{part_id} sold count = #{count}"
      p_part = SaleOrderPart.find(:first, :conditions => {:sale_order_id => self.id, :part_id => part_id})
      p_part = self.sale_order_parts.new(:sale_order_id => self.id, :part_id => part_id, :sold => 0, :delivered => 0) if p_part.nil?
      p_part.sold = count
      p_part.save
    end

    puts "========== leaving SaleOrder::update_parts ================"
    pp(self)
  end


end
