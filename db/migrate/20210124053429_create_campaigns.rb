class CreateCampaigns < ActiveRecord::Migration[6.1]
  def change
    create_table :campaigns do |t|
      t.string :name
      t.string :image
      t.float :percentage_raised
      t.float :target_amount
      t.string :sector
      t.string :country
      t.decimal :investment_multiple
      t.boolean :open
      t.string :currency

      t.timestamps
    end
  end
end
