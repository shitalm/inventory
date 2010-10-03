class PaymentsController < ApplicationController
	active_scaffold :payment do |config|
		config.columns = [:payment_type, :date, :amount, :details]
		config.columns[:payment_type].form_ui = :select
	end
end
