class BookFilter
  def call(params)
    @book_attribute = Genre.find_by(id: params[:genre_id]) if params[:genre_id]

    @book_attribute = Status.find_by(id: params[:status_id]) if params[:status_id]

    @book_attribute = Cover.find_by(id: params[:cover_id]) if params[:cover_id]

    @book_attribute&.books
  end
end