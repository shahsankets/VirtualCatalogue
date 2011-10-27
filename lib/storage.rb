require 'product'

class Storage
  attr_reader :products, :quantity

  PRODUCTS_FILE = "../products.csv"
  QUANTITY_FILE = "../quantity.csv"

  #products file: id, barcode, name, brand, description, category, price, picture, location
  #quiantity file: id, quantity

  def initialize
    @products = []
    @quantity = {}
  end

  def load_products_file filename=PRODUCTS_FILE
    File.open(filename, 'r').each do |line|
      temp = line.split(",")
      p = Product.new(temp[0].to_i, *(temp[1..-1]) )
      @products.push(p)
    end
  end

  def load_quantity_file filename_quantity = QUANTITY_FILE
    File.open(filename_quantity, 'r').each do |line|
      id,q = line.split(",")
      @quantity[id.to_i] = q.to_i
    end
  end

  def get_quantity id
    return @quantity[id]
  end

  def add_product product
    File.open(PRODUCTS_FILE, 'w+') do |file|
       file.puts("#{product.id}, #{product.barcode},#{product.name}, #{product.brand}, #{product.description}, #{product.category_id}, #{product.price}, #{product.picture}, #{product.location}")
    end

    self.load_products_file
  end
end