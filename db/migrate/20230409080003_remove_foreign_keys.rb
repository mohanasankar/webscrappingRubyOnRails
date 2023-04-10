class RemoveForeignKeys < ActiveRecord::Migration[7.0]
  def change
    remove_foreign_key :product_images, :products
    remove_foreign_key :products, :categories
  end
end
