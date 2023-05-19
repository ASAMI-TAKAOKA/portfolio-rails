class Category < ApplicationRecord
  has_ancestry # これでancestryを使えるようになる。
  has_many :post_category_relations #, dependent: :destroy, foreign_key: 'category_ids'
  has_many :posts, through: :post_category_relations

  # 親カテゴリーを抽出する
  def self.get_parent_category_array
    parent_category_array = [] # 配列として定義する
    Category.where(ancestry: nil).each do |parent|
      parent_category_array << { id: parent.id, name: parent.name } # ハッシュを配列に追加する
    end
    return parent_category_array
  end
end