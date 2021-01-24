class CreateInvestments < ActiveRecord::Migration[6.1]
  def change
    create_table :investments do |t|
      t.string :user_name
      t.decimal :investment_amount
      t.string :currency
      t.integer :campaign_id

      t.timestamps
    end
  end
end
