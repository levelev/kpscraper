require "open-uri"
require "nokogiri"

class Agent
  attr_accessor :attributes

  def initialize(attributes = {})
#   @listing_url = attributes[:listing_url]
    @attributes = attributes
  end
end

def get_directory
  urls = []
  page = 0
  base = "https://branchenbuch.kaeuferportal.de/immobilienverkauf?page="
  while page < 2
    url ="#{base}#{page}"
    urls << url
    page += 1
  end
  return urls
end

def get_listings
  listings = []
  urls = get_directory
  urls.each do |url|
    # scrape url for listings
    p url
    doc = Nokogiri::HTML(open(url))
    doc.css('.profile-link a').each do |link|
      listings  << "https://branchenbuch.kaeuferportal.de#{link['href']}"
    end
  end
    listings.each do |listing|
      scrape_url(listing)
    end

end

def scrape_url(url)
  attributes = {}
  doc = Nokogiri::HTML(open(url))
  attributes[:company] = doc.css('address h1').text
  attributes[:street] = doc.css('.contactDataHolder address > span:nth-child(2) > span:nth-child(1)').text
  p attributes
end


def scrape_listings
  listings = get_listings
  listings.each do |listing|
    p "Scraping #{listing}"
    scrape_url(listing)
  end
end

def scraper
  get_directory
  get_listings
  scrape_listings
end



# url = "https://branchenbuch.kaeuferportal.de/berlin/immobilienverkauf/mcmakler-gmbh-darmstadt"
