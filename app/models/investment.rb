class Investment < ApplicationRecord
    validates :investment_amount, presence:true
  
    belongs_to :campaign
end
