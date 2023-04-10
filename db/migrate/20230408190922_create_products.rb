class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :url
      t.string :title
      t.text :description
      t.string :price
      t.string :mobile_number
      t.string :size
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end


