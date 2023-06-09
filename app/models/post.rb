class Post < ApplicationRecord
  include Rails.application.routes.url_helpers

  has_one_attached :image
  
  def image_url
    # 紐づいている画像のURLを取得する
    image.attached? ? url_for(image) : nil
  end

  has_many :post_category_relations, dependent: :destroy
  has_many :categories, through: :post_category_relations

  def category_name
    # 紐づいているカテゴリーのnameを取得する
    # pluckは引数に指定したカラムの値を配列で返してくれる
    # ["野菜"]こんな感じに
    categories.pluck(:name)
  end

  def user
    #インスタンスメソッドなので、selfはUserオブジェクトのインスタンス自身を表す
    return User.find_by(id: self.user_id)
  end
  
end
