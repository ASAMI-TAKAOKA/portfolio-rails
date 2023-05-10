class AddColumnToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :product_name, :string
    add_column :posts, :price, :integer
    add_column :posts, :store_information, :string
  end
end
