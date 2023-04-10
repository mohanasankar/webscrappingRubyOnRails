class ProductsController < ApplicationController
  # product.categories
  # product.product_images
protect_from_forgery with: :null_session

  # Add CORS headers to response
  before_action :set_cors_headers
  
  skip_before_action :verify_authenticity_token
product = Product.first
category = product.category
  def index
    products = Product.all
    render json:products,status:200
  end
  def show   

  category = Category.find_by(name:params[:name])
 
    if category.nil?
      render json:{error:"No Name is found"}
   

    else
      # render the existing product data
     
      urls = Product.joins(:category).where(categories: { name: category.name }).pluck(:url)
      render json:urls, status:200
  end
end
  def new
    products = Product.new
  end
  def create
    # category = products.category.create(comment_params)
require 'nokogiri'
require 'open-uri'
require 'net/http'
url = product_params[:url];

product = Product.find_by(url:url)
if !product.present?
category_params = { name: category_name }
isExit = Category.find_by(category_params)
if !isExit.present?
category = Category.create(category_params)
else
  category = isExit
end

if category.present?
  uri = URI.parse(url)
response = Net::HTTP.get_response(uri)
doc = Nokogiri::HTML(response.body)
title = doc.css('.B_NuCI').text.strip
description = doc.css('._1AN87F').text.strip
price = doc.css('._30jeq3')[1].text.strip
mobile_number = doc.css('._1V3wJf').text.strip
size = doc.css('._1q8vHb li').map(&:text)
category_name = doc.css('._2whKao')[1].text.strip
title.present? ? title : " "
description.present? ? description : " "
price.present? ? price : " "
mobile_number.present? ? mobile_number : " "
size.present? ? size.join(', ') : " "
    product = Product.new(url:url,
    title:title, 
    description:description, 
    price:price, 
    mobile_number:mobile_number, 
    size:size,
    category_id:category.id)
    if product.save
      render json:product,status:200
    else
      render json:{error:"unable to save"}
    end
  end
elsif product.updated_at < Time.now - 7*24*60*60
  # if the data is older than 1 week, retrieve updated data from data source
  uri = URI.parse(url)
  response = Net::HTTP.get_response(uri)
  doc = Nokogiri::HTML(response.body)
  title = doc.css('.B_NuCI').text.strip
  description = doc.css('._1AN87F').text.strip
  price = doc.css('._30jeq3')[1].text.strip
  mobile_number = doc.css('._1V3wJf').text.strip
  size = doc.css('._1q8vHb li').map(&:text)
  category_name = doc.css('._2whKao')[1].text.strip
  title.present? ? title : " "
  description.present? ? description : " "
  price.present? ? price : " "
  mobile_number.present? ? mobile_number : " "
  size.present? ? size.join(', ') : " "

  # params.require(:product).permit(:url,:description,:price,:mobile_number,:size,:category_id)
  # update the existing product with the updated data
  product.update(url:url,
  title:title, 
  description:description, 
  price:price, 
  mobile_number:mobile_number, 
  size:size)

  # render the updated product data
  render json:product, status:200
else
  render json:product, status:200
end

  end
  def update
    product = Product.find(params[:id])

    if product.update(product_params)
      render json:product,status:200
    else
      render json:{error:"unable to save"}
    end
  end
  private
    def product_params
      params.require(:product).permit(:url)
    end

    private
      def retrieve_updated_product(url)
      require 'nokogiri'
      require 'open-uri'
      require 'net/http'
      uri = URI.parse(url)
      response = Net::HTTP.get_response(uri)
      doc = Nokogiri::HTML(response.body)
      title = doc.css('.B_NuCI').text.strip
      description = doc.css('._1AN87F').text.strip
      price = doc.css('._30jeq3').text.strip
      mobile_number = doc.css('._1V3wJf').text.strip
      size = doc.css('._1q8vHb li').map(&:text)
      category_name = doc.css('._2whKao').map(&:text)
      title.present? ? title : " "
      description.present? ? description : " "
      price.present? ? price : " "
      mobile_number.present? ? mobile_number : " "
      size.present? ? size.join(', ') : " "
      category_id:'4'
      params.require(:product).permit(:url,:description,:price,:mobile_number,:size,:category_id)
    end
    private
  def set_cors_headers
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = 'POST, GET, OPTIONS'
    headers['Access-Control-Allow-Headers'] = 'Content-Type'
    headers['Access-Control-Max-Age'] = '1728000'
  end
end
