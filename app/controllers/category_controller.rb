class CategoryController < ApplicationController
    skip_before_action :verify_authenticity_token
    def index
    category = Category.all
    render json:products,status:200
  end
  def show
    category = Category..where(name: params[:name]).first
    if category.nil?
      render json:{error:"No name is found"}    
    else
      render json:products,status:200
    end
  end
  def new
    category = Category.new
  end
  def create
    category = Category.new(name:cato_params[:name])
    if category.save
      redirect_to category
    else
      render json:{error:"unable to save"}
    end
  end
  private
    def cato_params
      params.require(:category).permit(:name)
    end
end
