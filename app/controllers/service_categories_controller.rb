class ServiceCategoriesController < ApplicationController
  before_action :set_service_category, only: %i[ show update destroy ]

  def index
    @service_categories = ServiceCategory.all
  end

  def show
  end

  def create
    @service_category = ServiceCategory.new(service_category_params)

    if @service_category.save
      render :show, status: :created, location: @service_category
    else
      render json: @service_category.errors, status: :unprocessable_entity
    end
  end

  def update
    if @service_category.update(service_category_params)
      render :show, status: :ok, location: @service_category
    else
      render json: @service_category.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @service_category.destroy!
  end

  private

    def set_service_category
      @service_category = ServiceCategory.find(params[:id])
    end


    def service_category_params
      params.require(:service_category).permit(:name)
    end
end
