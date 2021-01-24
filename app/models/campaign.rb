class Campaign < ApplicationRecord
    has_many :investments

    scope :open, ->{ where("open == ?", true) }
    scope :target_desc, ->{ order("target_amount DESC")}
    scope :target_asc, ->{ order("target_amount ASC")}
    # We can also use class methods instead of scopes

    # Scopes are also chainable. Love it!
    scope :open_and_target_desc, ->{ open.target_desc }
    scope :open_and_target_asc, ->{ open.target_asc }

    # Scope can take an argument that the user passes, but the 
    # convention in rails is to use class methods when accepting arguments
    # def target_above(amount)
    #     where("target_amount > ?", amount)
    # end
    # scope :target_above, ->(amount) { where("target_amount > ?", amount) }


end