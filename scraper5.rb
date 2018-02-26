require "open-uri"
require "nokogiri"
require "csv"

def scraper

  p Time.now

  filepath = 'listings.csv'
  listings = []

  CSV.foreach(filepath) do |row|
    listing = row[0]
    listings << listing
  end

  listings.each do |listing|
    p "Scraping #{listing}"
    attributes = {}
    begin
      doc = Nokogiri::HTML(open(listing))
      rescue
    end

    if doc != nil
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

      listing_array = []

      attributes.each do |key, value|
        listing_array << value
      end

      csv_options = { col_sep: ',', force_quotes: false, quote_char: '"' }
      results_csv = 'headers.csv'

      CSV.open(results_csv, 'ab', csv_options) do |csv|
        csv << listing_array
      end
    end
  end

  p Time.now
end

scraper
