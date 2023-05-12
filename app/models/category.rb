class Category < ApplicationRecord
  has_many :post_category_relations, dependent: :destroy, foreign_key: 'category_ids'
  has_many :posts, through: :post_category_relations
end
