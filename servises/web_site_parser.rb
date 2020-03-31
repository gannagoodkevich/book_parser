require 'net/http'
require 'curb'

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