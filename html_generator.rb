require "json"
require "open-uri"

class HtmlGenerator
  
  def show
    print_header
    puts "Action: Show"
    print_footer
  end

  def index
    print_header
    puts "Action: Index"

    products = retrieve_data
    
    products.each do |product|
      display_product(product)
    end

    print_footer
  end

  private

  def display_product(product)
    puts "<div class='product'>"
    puts "<h1>#{product['name']}</h1>"
    puts "<img src=#{product['image_thumb_url']}>"
    puts "<div class='ps'>"
    puts "<p>#{product['id']}<br>"
    puts "#{product['producer_name']}<br>"
    puts "#{product['primary_category']}<br>"
    puts "#{product['secondary_category']}<br>"
    puts "#{product['package']}<br>"
    puts "$#{product['price_in_cents']/100.0}</p>"
    puts "</div>"
    puts "</div>"
  end

  def print_header
    puts "<html>"
    puts "  <head>"
    puts "    <title>Connoisseur</title>"
    puts "    <style>.ps {float:left;}img {float: left;} .product {clear:both;}</style>"
    puts "  </head>"
    puts "  <body>"
  end

  def print_footer
    puts "  </body>"
    puts "</html>"
  end

  def retrieve_data
    response = open("http://lcboapi.com/products.json").read
    data = JSON.parse(response)
    return data["result"]
  end
end