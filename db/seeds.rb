require '/media/asus/Ann/Films/servises/web_site_parser.rb'

parser = WebSiteParser.new("https://biblio.by/biblio-books.html?cat=4921")

parser.book_genres_links.each do |key, value|
  links = []
  threads = []
  puts value
  num_of_pages = parser.book_genres_numbers[key] / 96
  if num_of_pages == 0
    links << value
  else
    num_of_pages.times do |i|
      links << value + "&p=#{i+1}"
    end
  end
  genre = Genre.create!(title: key)

  links.each do |link|
    page = Nokogiri::HTML(Curl.get(link).body_str)
    books_genres = page.search('//div[@class = "des-container"]').each_slice(4)
    books_genres.each do |books_genre|
      threads << Thread.new(books_genre) do |books_genre|
        begin
          books_genre.each do |name|
            genre.books.create!(title: name.search('div[@class = "product-name"]').first.content, author: name.search('p[@class = "author"]').first.content)
          end
        ensure
          ActiveRecord::Base.clear_active_connections!
        end
      end
      threads.each {|thread| thread.join}
    end
  end
end

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
  cover = Cover.create!(cover_type: key)

  links.each do |link|
    page = Nokogiri::HTML(Curl.get(link).body_str)
    books_genres = page.search('//div[@class = "des-container"]').each_slice(4)
    books_genres.each do |books_genre|
      threads << Thread.new(books_genre) do |books_genre|
        begin
          books_genre.each do |name|
            cover.books << Book.find_by(title: name.search('div[@class = "product-name"]').first.content, author: name.search('p[@class = "author"]').first.content) if Book.find_by(title: name.search('div[@class = "product-name"]').first.content, author: name.search('p[@class = "author"]').first.content)
          end
        ensure
          ActiveRecord::Base.clear_active_connections!
        end
      end
      threads.each {|thread| thread.join}
    end
  end
end

parser.book_statuses_links.each do |key, value|
  links = []
  threads = []
  puts value
  num_of_pages = parser.book_statuses_numbers[key] / 96
  if num_of_pages == 0
    links << value
  else
    num_of_pages.times do |i|
      links << value + "&p=#{i+1}"
    end
  end
  status = Status.create!(status_title: key)

  links.each do |link|
    page = Nokogiri::HTML(Curl.get(link).body_str)
    books_genres = page.search('//div[@class = "des-container"]').each_slice(4)
    books_genres.each do |books_genre|
      threads << Thread.new(books_genre) do |books_genre|
        begin
          books_genre.each do |name|
            status.books << Book.find_by(title: name.search('div[@class = "product-name"]').first.content, author: name.search('p[@class = "author"]').first.content) if Book.find_by(title: name.search('div[@class = "product-name"]').first.content, author: name.search('p[@class = "author"]').first.content)
          end
        ensure
          ActiveRecord::Base.clear_active_connections!
        end
      end
      threads.each {|thread| thread.join}
    end
  end
end