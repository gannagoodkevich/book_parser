class BooksController < ApplicationController
  before_action :books_all, only: %i[index destroy]
  before_action :genres_all, only: %i[new index edit]
  before_action :covers_all, only: %i[new index edit]
  before_action :status_all, only: %i[new index edit]
  before_action :find_book, only: %i[search edit update destroy]

  def new
    @book = Book.new
  end

  def index
    @books = BookFilter.new.call(params) if BookFilter.new.call(params)

    @books = BookSearchQuery.new(@books).call(params[:search_parameter], params[:search_word]) if params[:search_word]

    @books = BookOrederer.new(@books).call(params[:order]) if params[:order] && BookOrederer.new(@books).call(params[:order])

    @books = @books.page params[:page]
  end

  def search
    @books = BookSearchQuery(@books).call(params[:search_parameter], params[:search_word])
  end

  def create
    @genre = Genre.find_by(id: params[:book][:genre_id])
    @book = @genre.books.create!(book_params)
    @status = Status.find_by(id: params[:book][:status_id])
    @status.books << @book
    @cover = Cover.find_by(id: params[:book][:cover_id])
    @cover.books << @book
    respond_to do |format|
      format.js
    end
  end

  def update
    @book.update!(book_params)
  end

  def destroy
    @book.destroy!
    @books = @books.page params[:page]
    respond_to do |format|
      format.js
    end
  end

  private

  def book_params
    params.require(:book).permit(:title, :author, :genre_id, :cover_id, :status_id)
  end

  def books_all
    @books = Book.all
  end

  def genres_all
    @genres = Genre.all
  end

  def covers_all
    @covers = Cover.all
  end

  def status_all
    @statuses = Status.all
  end

  def find_book
    @book = Book.find_by(id: params[:id])
  end
end
