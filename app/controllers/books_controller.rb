class BooksController < ApplicationController
  def new
    @book = Book.new
  end

  def index
    if params[:genre_id]
      @genre = Genre.find_by(id: params[:genre_id])
      @books = @genre.books
    else
      @books = Book.all
    end
    @genres = Genre.all
  end

  def create
    @book = Book.create!(book_params)
    respond_to do |format|
      format.js
    end
  end

  def edit
    @book = Book.find_by(id: params[:id])
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

  private

  def book_params
    params.require(:book).permit(:title, :author)
  end
end
