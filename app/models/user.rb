# frozen_string_literal: true
require "validator/email_validator"

class User < ActiveRecord::Base
  # バリデーション直前に実行
  before_validation :downcase_email
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  # devise :database_authenticatable, :registerable,
  #        :recoverable, :rememberable, :validatable
  # include DeviseTokenAuth::Concerns::User

  # has_secure_passwordはgem bcryptのメソッドで、以下4つの機能がある
  # パスワードを暗号化する
  # password_digestカラム を passwordとして扱うことができる
  # password_confirmation（データベースに保存されない仮想の属性）を使用できる
  # authenticate()メソッドを使用できる
  # 最大72文字まで
  # User.create()のときに入力必須バリデーションを追加してくれる
  has_secure_password

  # validates
  validates :name, presence: true,
                   length: { maximum: 30, allow_blank: true }
  validates :email, presence: true,
                    email: { allow_blank: true }

  VALID_PASSWORD_REGEX = /\A[\w\-]+\z/
  validates :password, presence: true,
                      length: {
                        minimum: 8,
                        allow_blank: true
                      },
                      format: {
                        with: VALID_PASSWORD_REGEX,
                        message: :invalid_password,
                        allow_blank: true
                      },
                      allow_nil: true
  ## methods
  # class method  ###########################
  class << self
    # emailからアクティブなユーザーを返す
    def find_by_activated(email)
      find_by(email: email, activated: true)
    end
  end
  # class method end #########################

  # 自分以外の同じemailのアクティブなユーザーがいる場合にtrueを返す
  def email_activated?
    users = User.where.not(id: id)
    users.find_by_activated(email).present?
  end

  # リフレッシュトークンのJWT IDを記憶する
  def remember(jti)
    update!(refresh_jti: jti)
  end

  # リフレッシュトークンのJWT IDを記憶する
  def forget
    update!(refresh_jti: nil)
  end

  # ユーザーに紐づいた投稿情報を全て取得
  def posts
    return Post.where(user_id: self.id)
  end

  private

  # email小文字化
  def downcase_email
    self.email.downcase! if email
  end
end
