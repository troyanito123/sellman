class ProductsController < ApplicationController

  before_action :set_product, only: [:edit, :update, :destroy]
  before_action -> { authorize @product || Product }

  def index
    @products = Product.all
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    @product.user = current_user
    if @product.save
      flash[:success] = I18n.t 'product.create'
      redirect_to products_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    puts params.inspect
    @product.assign_attributes product_params
    if @product.save
      flash[:success] = I18n.t 'product.update'
      redirect_to products_path
    else
      render :edit
    end
  end

  def destroy
    @product.destroy
    flash[:success] = I18n.t 'product.destroy'
    redirect_to products_path
  end

  private
  def product_params
    params.require(:product).permit(:title, :description, :cost)
  end

  def set_product
    @product = Product.find(params[:id])
  end


end
