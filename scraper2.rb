require "open-uri"
require "nokogiri"

class Agent
  attr_accessor :attributes

  def initialize(attributes = {})
    # @listing_url = attributes[:listing_url]
    @attributes = attributes
  end
end


def add_attribute(attribute_name, attribute_selector, attribute_method)
  if doc.css(attribute_selector).empty?
    attribute = nil
  else
    attribute = "doc.css('#{attribute_selector}').#{attribute_method}"
  end
return "attributes[#{attribute_name}] = #{attribute}"
end


def scraper
  urls = []
  page = 19
  base = "https://branchenbuch.kaeuferportal.de/immobilienverkauf?page="
  while page < 30
    url ="#{base}#{page}"
    urls << url
    p "Added #{url} to URLs"
    page += 1
  end
  listings = []
  urls.each do |url|
    # scrape url for listings
    doc = Nokogiri::HTML(open(url))
    doc.css('.profile-link a').each do |link|
      listings  << "https://branchenbuch.kaeuferportal.de#{link['href']}"
      p "Added https://branchenbuch.kaeuferportal.de#{link['href']} to listings"
    end
  end

  listings = ["https://branchenbuch.kaeuferportal.de/zirndorf/immobilienverkauf/b-und-z-immoservice-bernd-barthmus-und-markus-zachmann-gbr"]
  listings.each do |listing|
    p "Scraping #{listing}"
    attributes = {}
      doc = Nokogiri::HTML(open(listing))
      company = doc.css('address h1')
      company.empty? ? attributes["company"] = nil : attributes["company"] = company.text

      logo = doc.css('.logoAlignHolder img')
      logo.empty? ? attributes["logo"] = nil : attributes["logo"] = "https:#{logo.attr('src')}"

      ratings = doc.css('.ratings span')
      ratings.empty? ? attributes["ratings"] = nil : attributes["ratings"] = ratings.text.to_i

      stars = doc.css('.logoRating .h2Blue')
      stars.empty? ? attributes["stars"] = nil : attributes["stars"] = stars.text.gsub(",",".").to_f

      street = doc.css('.contactDataHolder address > span:nth-child(2) > span:nth-child(1)')
      street.empty? ? attributes["street"] = nil : attributes["street"] = street.text

      zip = doc.css('.contactDataHolder address > span:nth-child(2) > span:nth-child(3)')
      zip.empty? ? attributes["zip"] = nil : attributes["zip"] = zip.text

      city = doc.css('.contactDataHolder address > span:nth-child(2) > span:nth-child(4)')
      city.empty? ? attributes["city"] = nil : attributes["city"] = city.text

      phone = doc.css('.contactDataHolder address > span:nth-child(4)')
      phone.empty? ? attributes["phone"] = nil : attributes["phone"] = phone.text

      email = doc.css('.contactDataHolder address > span:nth-child(6)')
      email.empty? ? attributes["email"] = nil : attributes["email"] = email.text

      homepage = doc.css('.contactDataHolder address > a')
      homepage.empty? ? attributes["homepage"] = nil : attributes["homepage"] = homepage.attr('href').value

      contact_name = doc.css('div.partner > address > strong')
      contact_name.empty? ? attributes["contact_name"] = nil : attributes["contact_name"] = contact_name.text

      contact_phone = doc.css('div.partner > address > span:nth-child(3)')
      contact_phone.empty? ? attributes["contact_phone"] = nil : attributes["contact_phone"] = contact_phone.text

      contact_email = doc.css('div.partner > address > span:nth-child(5)')
      contact_email.empty? ? attributes["contact_email"] = nil : attributes["contact_email"] = contact_email.text

      attributes["listing_url"] = listing

      a = Agent.new(attributes)
      p "created Agent:"
    p a
  end
end






scraper

