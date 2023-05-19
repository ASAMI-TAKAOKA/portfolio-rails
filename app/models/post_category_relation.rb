class PostCategoryRelation < ApplicationRecord
  belongs_to :post
  belongs_to :category

  # 多階層カテゴリデータ生成メソッドを定義
  def self.maltilevel_category_create(post, parent_id, children_id, grandchildren_id)
    # 親カテゴリーのIDを引数として受け取れた場合,処理を実行する。
    if parent_id.present?
      # Categoryモデルから引数で受け取った親カテゴリーIDに対応するレコードを抽出し、変数に代入する。
      category = Category.find(parent_id)
      # PostCategoryRelation(中間テーブル)にレコードを作成する。
      PostCategoryRelation.create(post_id: post.id, category_id: category.id)
    end

    if children_id.present?
      category = Category.find(children_id)
      PostCategoryRelation.create(post_id: post.id, category_id: category.id)
    end

    if grandchildren_id.present?
      category = Category.find(grandchildren_id)
      PostCategoryRelation.create(post_id: post.id, category_id: category.id)
    end
  end
end
