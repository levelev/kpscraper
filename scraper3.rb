require "open-uri"
require "nokogiri"

class Agent
  attr_accessor :attributes

  def initialize(attributes = {})
    # @listing_url = attributes[:listing_url]
    @attributes = attributes
  end
end





def scraper
  # urls = []
  # page = 19
  # base = "https://branchenbuch.kaeuferportal.de/immobilienverkauf?page="
  # while page < 30
  #   url ="#{base}#{page}"
  #   urls << url
  #   p "Added #{url} to URLs"
  #   page += 1
  # end
  # listings = []
  # urls.each do |url|
  #   # scrape url for listings
  #   doc = Nokogiri::HTML(open(url))
  #   doc.css('.profile-link a').each do |link|
  #     listings  << "https://branchenbuch.kaeuferportal.de#{link['href']}"
  #     p "Added https://branchenbuch.kaeuferportal.de#{link['href']} to listings"
  #   end
  # end

  listings = ["https://branchenbuch.kaeuferportal.de/zirndorf/immobilienverkauf/b-und-z-immoservice-bernd-barthmus-und-markus-zachmann-gbr"]
  listings.each do |listing|
    p "Scraping #{listing}"
    attributes = {}
      doc = Nokogiri::HTML(open(listing))
      begin
        attributes[company] = doc.css('address h1').text
        rescue
      end
      begin
        attributes[logo] = "https:#{doc.css('.logoAlignHolder img').attr('src')}"
        rescue
      end

      begin
      attributes[ratings] = doc.css('.ratings span').text.to_i
      rescue
      end

      begin
      attributes[stars] = doc.css('.logoRating .h2Blue').text.gsub(",",".").to_f
      rescue
      end

      begin
      attributes[street] = doc.css('.contactDataHolder address > span:nth-child(2) > span:nth-child(1)').text
      rescue
      end

      begin

      attributes[zip] = doc.css('.contactDataHolder address > span:nth-child(2) > span:nth-child(3)').text
      rescue
      end

      begin

      attributes[city] = doc.css('.contactDataHolder address > span:nth-child(2) > span:nth-child(4)').text
      rescue
      end

      begin
      attributes[phone] = doc.css('.contactDataHolder address > span:nth-child(4)').text
      rescue
      end

      begin
      attributes[email] = doc.css('.contactDataHolder address > span:nth-child(6)').text
      rescue
      end

      # begin
      # attributes[:homepage] = homepage.attr('href').value
      # rescue
      # end

      begin

      attributes[contact_name] = doc.css('div.partner > address > strong').text
      rescue
      end

      begin
      attributes[contact_phone] = doc.css('div.partner > address > span:nth-child(3)').text

      rescue
      end

      begin
      attributes[contact_email] = doc.css('div.partner > address > span:nth-child(5)').text

      rescue
      end

      begin
      attributes[listing_url] = listing

      rescue

      end

      p "attributes: #{attributes}"
      a = Agent.new(attributes)
      p "created Agent:"
    p a
  end
end




def add_attribute(attributes , doc, attribute_name, attribute_selector, attribute_method)
  p doc.css(attribute_selector)
  if doc.css(attribute_selector).empty?
    attribute = nil
  else
    attribute = doc.css('attribute_selector').call(attribute_method)
    # attribute = "doc.css('#{attribute_selector}').#{attribute_method}"
  end
# return "attributes[#{attribute_name}] = #{attribute}"
return attributes[attribute_name] = attribute
end

scraper

