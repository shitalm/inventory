require 'pp'
class SaleOrderPart < ActiveRecord::Base

  validate :validate_part
  validates_numericality_of :delivered, :only_integer => true, :greater_than_or_equal_to => 0

  belongs_to :sale_order
  belongs_to :part

  def to_label
    " delivery count for #{part.name} sold = #{sold} "
  end

  def pretty_print(pp)
    puts "#{part.name} sold=#{sold} delivered=#{delivered}"
  end

  def validate_part
    errors.add(:delivered, "Delivered count (#{delivered}) can not be greater than sale count (#{sold})") if delivered > sold
  end

end
