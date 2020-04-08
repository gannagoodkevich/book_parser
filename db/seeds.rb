require 'csv'

books_CSV = CSV.read("/media/asus/Ann/Films/db/books.csv")

genres = books_CSV.map do |book|
   book[2]
end

genres.uniq!

statuses = books_CSV.map do |book|
  book[4]
end

statuses.uniq!
statuses = statuses.compact

covers = books_CSV.map do |book|
  book[3]
end

covers.uniq!
covers = covers.compact

books = books_CSV.map do |book|
  status_index = nil
  cover_index = nil
  status_index = statuses.index(book[4])+1 if statuses.index(book[4])
  cover_index = covers.index(book[3])+1 if covers.index(book[3])
  { "title" => book[0], "author" => book[1], "genre_id" => genres.index(book[2]) + 1, "status_id" => status_index, "cover_id" => cover_index }
end

genres = genres.map do |genre|
  { "title" => genre }
end

statuses = statuses.map do |genre|
  { "status_title" => genre }
end

covers = covers.map do |genre|
  { "cover_type" => genre }
end


puts books.last.inspect
Book.import %w[title author genre_id status_id cover_id], books
Genre.import %w[title], genres
Status.import %w[status_title], statuses
Cover.import %w[cover_type], covers