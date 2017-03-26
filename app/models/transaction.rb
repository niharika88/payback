class Transaction < ApplicationRecord
 belongs_to :user
 validates_presence_of :transaction_description, :amount_spent, :transaction_type
 validates_numericality_of :amount_spent, :on => :create
end
