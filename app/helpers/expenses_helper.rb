module ExpensesHelper
	def expense_entity_id_form_column(record, input_name)
		puts "expense_entity_id_column: record = #{record.inspect}, input_name=#{input_name}"
		if record.expense_entity_type == nil
			out = select :record, :expense_entity_id, [["Choose entity above", 0]], {}, {:id => "record_expense_entity_id_"}  
		else 
			# following assumes that all expense entity models have id and name
			out = collection_select(:record, :expense_entity_id, record.expense_entity_type.constantize.all, :id, :name, {:include_blank => 'None'}, {:id => "record_expense_entity_id_"}) 
		end
		puts "out = #{out}"
		out
	end
end
