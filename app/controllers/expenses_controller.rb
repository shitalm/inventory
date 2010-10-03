class ExpensesController < ApplicationController
	active_scaffold :expense do |config|
	config.columns = [:entity, :date, :expense_type, :amount]
	config.list.columns = [:entity, :date, :expense_type, :amount]
	config.show.columns = [:entity, :date, :expense_type, :amount]
	config.create.columns= [:expense_entity_type, :expense_entity_id, :date, :expense_type, :amount]
	config.update.columns= [:expense_entity_type, :expense_entity_id, :date, :expense_type, :amount]
	config.columns[:expense_type].form_ui = :select
	config.columns[:expense_entity_type].form_ui = :select 
	config.columns[:expense_entity_type].update_column = :expense_entity_id
	config.columns[:expense_entity_type].options = 
		{
			:include_blank => 'Choose entity',
			:options => ExpenseEntity.find(:all).collect { |entity| [entity.name, entity.entity] }
		}
	end

end
