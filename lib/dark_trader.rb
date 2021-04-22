require 'rubygems'
require 'nokogiri'  
require 'open-uri'

def scrapper
    pages = Nokogiri::HTML(URI.open("https://coinmarketcap.com/all/views/all/"))
end

def crypto(page)
    array_name = []
    array_value = []
    name_of_crypto = page.xpath('//tr//td[2]')
    value_of_crypto = page.xpath('//tr//td[5]')
    
    name_of_crypto.each do |name|
        array_name << name.text
       # "a money will be added\n\n"
    end
    value_of_crypto.each do |values|
        array_value << values.text
       # "a value of money will be added\n\n"
    end

    array_value_of_crypto = array_value.map {|word| word.gsub('$', '') } 
    result = Hash[array_name.zip array_value_of_crypto]

    result.each do |name, value|
    final_crypto = {name => value.to_f}
    end
end

puts crypto(scrapper)