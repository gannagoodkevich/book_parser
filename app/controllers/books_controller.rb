class BooksController < ApplicationController
  def new
    @book = Book.new
    @genres = Genre.all
  end

  def index
    if params[:genre_id]
      @genre = Genre.find_by(id: params[:genre_id])
      @books = @genre.books
    else
      if params[:order]
        @books = Book.order(title: :desc)
      else
        @books = Book.order(title: :asc)
      end
    end
    @genres = Genre.all
  end

  def create
    @genre = Genre.find_by(id: params[:book][:genre_id])
    puts @genre
    @book = @genre.books.create!(book_params)
    respond_to do |format|
      format.js
    end
  end

  def edit
    @book = Book.find_by(id: params[:id])
    @genres = Genre.all
  end

  def update
    @book = Book.find_by(id: params[:id])
    @book.update!(book_params)
  end

  def destroy
    @book = Book.find_by(id: params[:id])
    @books = Book.all
    @book.destroy!
    respond_to do |format|
      format.js
    end
  end

  def sort
    @books = Book.order(title: :desc)
    @genres = Genre.all
    respond_to do |format|
      format.js
    end
  end

  private

  def book_params
    params.require(:book).permit(:title, :author, :genre_id)
  end
end
