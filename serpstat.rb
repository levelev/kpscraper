require "open-uri"
require "nokogiri"
require "csv"

def load_source_csv
  source_csv_path = 'source_csv.csv'
  source_array = []
  CSV.foreach(source_csv_path) do |row|
    source_array << row
  end
  return source_array
end

def get_domain_serpstat(source_array)
  source_array.each do |listing|
    domain = listing[9]
    begin
      domain = URI.parse(domain).host.gsub("www.", "")
    rescue
      domain = "example.notexist"
    end
    scrape_serpstat(domain)
  end
end

def scrape_serpstat(domain)
  serpstat_query = "https://serpstat.com/domains/index/?search_type=subdomains&query=#{domain}&se=g_de"
  stat_array = []
  begin
    doc = Nokogiri::HTML(open(serpstat_query))
    rescue
  end
  if doc != nil
    stats = doc.css('.dashboard_stat_num')
    stats.each {|num| stat_array << num.text.strip.to_i}
  else
    stat_array = [0,0,0,0]
  end
  return stat_array
end


get_domain_serpstat(load_source_csv)

