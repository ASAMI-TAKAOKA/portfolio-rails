class Api::V1::CategoriesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    @categories = Category.order(created_at: :desc)
    render json: { status: 'SUCCESS', message: 'Loaded categories', category: @categories }
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      render json: { status: 'SUCCESS', data: @category }
    else
      render json: @category.errors, status: :unprocessable_entity
    end
  end

  def update
    @category = Category.find(params[:id])
    if @category.update(category_params)
      render json: { category: @category }, status: :ok
    else
      render json: { errors: @category.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @category = Category.find(params[:id])
    if @category.destroy
      head :ok
    else
      render json: @category.errors, status: :unprocessable_entity
    end
  end
  private

  def category_params
    params.permit(:name)
  end
end
