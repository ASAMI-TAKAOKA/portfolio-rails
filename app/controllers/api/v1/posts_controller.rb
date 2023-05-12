class Api::V1::PostsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    @posts = Post.order(created_at: :desc)
    render json: { status: 'SUCCESS', message: 'Loaded posts', post: @posts }, methods: [:image_url]
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      render json: { status: 'SUCCESS', data: @post }, methods: [:image_url]
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  def show
    @post = Post.find(params[:id])
    render json: { post: @post }, status: :ok, methods: [:image_url]
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
      params.permit(:product_name, :price, :store_information, :body, :created_at, :image, category_ids: [])
    end
end