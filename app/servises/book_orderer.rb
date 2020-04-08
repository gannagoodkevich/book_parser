class BookOrederer
  def initialize(books)
    @books = books
  end

  def call(param)
    send(param)
  end

  private

  def book_title_asc
    @books.order(title: :asc)
  end

  def book_title_desc
    @books.order(title: :desc)
  end

  def book_genre_title_asc
    @books.includes(:genre).order('genres.title ASC')
  end

  def book_genre_title_desc
    @books.includes(:genre).order('genres.title DESC')
  end

  def book_status_title_asc
    @books.includes(:status).order('statuses.status_title ASC')
  end

  def book_status_title_desc
    @books.includes(:status).order('statuses.status_title DESC')
  end

  def book_cover_title_asc
    @books.includes(:cover).order('covers.cover_type ASC')
  end

  def book_cover_title_desc
    @books.includes(:cover).order('covers.cover_type DESC')
  end
end