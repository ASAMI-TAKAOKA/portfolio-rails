class Api::V1::PostsController < ApplicationController
  # skip_before_action :verify_authenticity_token
  # before_action :authenticate_user!
  before_action :authenticate_active_user
  
  # def index
  #   # 本来はDBから取得する => current_user.posts
  #   posts = [
  #     { id: 1, name: 'Rails MyPost01', updatedAt: '2020-04-01T12:00:00+09:00' },
  #     { id: 2, name: 'Rails MyPost02', updatedAt: '2020-04-05T12:00:00+09:00' },
  #     { id: 3, name: 'Rails MyPost03', updatedAt: '2020-04-03T12:00:00+09:00' },
  #     { id: 4, name: 'Rails MyPost04', updatedAt: '2020-04-04T12:00:00+09:00' },
  #     { id: 5, name: 'Rails MyPost05', updatedAt: '2020-04-01T12:00:00+09:00' }
  #   ]
  #   render json: posts
  # end

  # def index
  #   @posts = Post.includes(:categories).order(created_at: :desc)
  #   # get_parent_category_arrayメソッドの戻り値として受け取った配列をインスタンス変数に代入する。
  #   @parent_category_array = Category.get_parent_category_array

  #   render json: { status: 'SUCCESS',
  #                  message: 'Loaded posts',
  #                  post: @posts.as_json(methods: [:image_url, :category_name]),
  #                  parent_category_array: @parent_category_array.as_json,
  #                }
  # end

  def index
    posts = []
    date = Date.new(2021,4,1)
    10.times do |n|
      id = n + 1
      name = "#{current_user.name} post #{id.to_s.rjust(2, "0")}"
      updated_at = date + (id * 6).hours
      posts << { id: id, name: name, updatedAt: updated_at }
    end
    # 本来はcurrent_user.posts
    render json: posts
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      # maltilevel_category_createメソッドに引数を4つ渡して実行する。
      PostCategoryRelation.maltilevel_category_create(
        @post,
        params[:parent_id],
        params[:children_id],
        params[:grandchildren_id]
      )
      render json: { status: 'SUCCESS', data: @post.as_json(methods: [:image_url, :category_name]) }
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  def show
    @post = Post.find(params[:id])
    # @user = User.find_by(id: @post.user_id) 代わりにpost.rbで定義したuser methodを使用する
    user = @post.user
    render json: { status: 'SUCCESS',
                   message: 'Loaded post',
                   post: @post.as_json(methods: [:image_url, :category_name]),
                   user: user.as_json
                 }
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      render json: { post: @post }, status: :ok
    else
      render json: { errors: @post.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.destroy
      head :ok
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  private
    def post_params
      params.permit(:product_name, :price, :store_information, :body, :created_at, :image, { category_ids: [] })
    end
end