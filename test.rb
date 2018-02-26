require 'csv'

filepath = 'listings.csv'
listings = []

CSV.foreach(filepath) do |row|
  listing = row[0]
  print listing
  p "\n"
  listings << listing
end


p listings
























# def add_attribute(attribute_name, attribute_selector, attribute_method)
#   if doc.css(attribute_selector).empty?
#     attribute = nil
#   else
#     attribute = "doc.css('#{attribute_selector}').#{attribute_method}"
#   end
# return "attributes[#{attribute_name}] = #{attribute}"
# end


# def construct(attribute_name, attribute_selector, attribute_method)
#   attribute = "doc.css('#{attribute_selector}').#{attribute_method}"
#   return "attributes[#{attribute_name}] = #{attribute}"
# end




#  construct("heading", "h1", "text")


# attributes["company"] = doc.css('address h1').text
#       attributes["logo"] = "https:#{doc.css('.logoAlignHolder img').attr('src')}"
#       attributes["ratings"] = doc.css('.ratings span').text.to_i
#       attributes["stars"] = doc.css('.logoRating .h2Blue').text.gsub(",",".").to_f
#       attributes["street"] = doc.css('.contactDataHolder address > span:nth-child(2) > span:nth-child(1)').text
#       attributes["zip"] = doc.css('.contactDataHolder address > span:nth-child(2) > span:nth-child(3)').text
#       attributes["city"] = doc.css('.contactDataHolder address > span:nth-child(2) > span:nth-child(4)').text
#       attributes["phone"] = doc.css('.contactDataHolder address > span:nth-child(4)').text
#       attributes["email"] = doc.css('.contactDataHolder address > span:nth-child(6)').text
#       homepage = doc.css('.contactDataHolder address > a')
#       homepage.empty? ? attributes["homepage"] = nil : attributes["homepage"] = homepage.attr('href').value
#       attributes["contact_name"] = doc.css('div.partner > address > strong').text
#       attributes["contact_phone"] = doc.css('div.partner > address > span:nth-child(3)').text
#       attributes["contact_email"] = doc.css('div.par
