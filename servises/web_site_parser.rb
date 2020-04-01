require 'net/http'
require 'curb'
require 'nokogiri'

class WebSiteParser
  def initialize(url)
    @root_url = Nokogiri::HTML(Curl.get(url).body_str)
  end

  def book_genres_links
    link_title_hash(@root_url.search('//dd').first.search('ol/li'))
  end

  def book_genres_numbers
    number_title_hash(@root_url.search('//dd').first.search('ol/li'))
  end

  def book_statuses_links
    link_title_hash(@root_url.search('//dd')[1].search('ol/li'))
  end

  def book_statuses_numbers
    number_title_hash( @root_url.search('//dd')[1].search('ol/li'))
  end

  def book_covers_links
    link_title_hash(@root_url.search('//dd').last.search('ol/li'))
  end

  def book_covers_numbers
    number_title_hash(@root_url.search('//dd').last.search('ol/li'))
  end

  private

  def link_title_hash(tags)
    title_link_hash = {}
    tags.each do |content|
      title = title(content)
      title_link_hash[title] = content.search('a').first['href']
    end
    title_link_hash
  end

  def number_title_hash(tags)
    numbers_title_hash = {}
    tags.each do |content|
      title = title(content)
      numbers_title_hash[title] = content.content.match(/\([0-9]+\)/)[0].gsub(/\(|\)/, '').to_i
    end
    numbers_title_hash
  end

  def title(content)
    content.content.gsub(/\n+/, '').gsub(/\([0-9]+\)/, '').strip
  end
end

parser = WebSiteParser.new("https://biblio.by/biblio-books.html?cat=4921")
puts parser.book_covers_links
puts parser.book_covers_numbers

parser.book_covers_links.each do |key, value|
  links = []
  threads = []
  puts value
  num_of_pages = parser.book_covers_numbers[key] / 96
  if num_of_pages == 0
    links << value
  else
    num_of_pages.times do |i|
      links << value + "&p=#{i+1}"
    end
  end
  puts key + "--->"
  puts links

  links.each do |link|
    threads << Thread.new(link) do |url|
      page = Nokogiri::HTML(Curl.get(url).body_str)
      page.search('//div[@class = "des-container"]').each do |name|
        puts name.search('div[@class = "product-name"]').first.content + " Written by: " + name.search('p[@class = "author"]').first.content
      end
      #puts page.search('//div[@class = "des-container"]').size
    end
  end
  threads.each {|thread| thread.join}
end