class Customer < ActiveRecord::Base
	has_many :sale_orders, :dependent => :destroy 
	has_many :expenses, :as => :expense_entity
end
