class BooksController < ApplicationController
  def new
    @book = Book.new
  end

  def index
    @books = Book.all
  end

  def create
    @book = Book.create!(book_params)
  end

  private

  def book_params
    params.require(:book).permit(:title, :author)
  end
end
