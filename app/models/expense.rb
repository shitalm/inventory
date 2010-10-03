class Expense < ActiveRecord::Base
  belongs_to :expense_type
  belongs_to :expense_entity, :polymorphic => true

  def entity
    return expense_entity.name + " (#{expense_entity.type})" if !expense_entity.nil?
  end

end
