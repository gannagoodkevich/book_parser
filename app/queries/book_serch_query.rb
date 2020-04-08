class BookSearchQuery
  def initialize(books)
    @visible_books = books
  end

  def call(parameter, searching_part)
    parameter = 'title' if parameter.nil?

    @books = []
    @books = @visible_books.where('title LIKE ?', "%#{searching_part}%") if parameter.eql?'title'

    @books = @visible_books.where('author LIKE ?', "%#{searching_part}%") if parameter.eql?'author'
    @books
  end
end