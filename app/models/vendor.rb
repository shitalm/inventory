class Vendor < ActiveRecord::Base
	has_many :purchase_orders, :dependent => :destroy 
	has_many :expenses, :as => :expense_entity
end
