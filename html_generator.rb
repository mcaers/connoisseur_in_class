require "json"
require "open-uri"

class HtmlGenerator
  
  def show(id)
    print_header
    puts "Action: Show"

    product = retrieve_data("http://lcboapi.com/products/#{id}.json")

    display_detailed_product(product)

    print_footer
  end

  def index
    print_header
    puts "Action: Index"

    products = retrieve_data("http://lcboapi.com/products.json")
    
    products.each do |product|
      display_product(product)
    end

    print_footer
  end

  private

  def display_detailed_product(product)
    puts "<div class='detailed_product'>"
    puts "<h1>#{product['name']}</h1>"
    puts "<img src=#{product['image_url']}>"
    puts "<div class='ps'>"
    puts "<p>#{product['id']}<br>"
    puts "#{product['producer_name']}<br>"
    puts "#{product['primary_category']}<br>"
    puts "#{product['secondary_category']}<br>"
    puts "#{product['origin']}<br>"
    puts "#{product['package']}<br>"
    puts "#{product['package_unit_type']}<br>"
    puts "$#{product['price_in_cents']/100.0}<br>"
    puts "#{product['serving_suggestion']}<br>"
    puts "#{product['tasting_note']}<br>"
    puts "#{product['tags']}<br>"
    puts "</div>"
    puts "</div>"

  end


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

  def retrieve_data(url)
    response = open(url).read
    data = JSON.parse(response)
    return data["result"]
  end
end