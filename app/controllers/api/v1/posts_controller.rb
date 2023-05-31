class Api::V1::PostsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    @posts = Post.includes(:categories).order(created_at: :desc)
    # get_parent_category_arrayメソッドの戻り値として受け取った配列をインスタンス変数に代入する。
    @parent_category_array = Category.get_parent_category_array

    render json: { status: 'SUCCESS',
                   message: 'Loaded posts',
                   post: @posts.as_json(methods: [:image_url, :category_name]),
                   parent_category_array: @parent_category_array.as_json,
                 }
  end

  # 親カテゴリーに紐付く子カテゴリーを抽出する
  def get_category_children
    @category_children = Category.find(params[:parent_id]).children
  end

  # 子カテゴリーに紐付く孫カテゴリーを抽出する
  def get_category_grandchildren
    @category_grandchildren = Category.find(params[:children_id]).children
  end

  def create
    @post = Post.new(post_params)
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
    render json: { status: 'SUCCESS', message: 'Loaded post', post: @post.as_json(methods: [:image_url, :category_name]) }
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