class BooksController < ApplicationController
  def new
    @book = Book.new
    @genres = Genre.all
    @covers = Cover.all
    @statuses = Status.all
  end

  def index
    @books = Book.all.order(title: :asc)

    if params[:genre_id]
      @genre = Genre.find_by(id: params[:genre_id])
      @books = @genre.books
    end

    if params[:status_id]
      @status = Status.find_by(id: params[:status_id])
      puts @status
      @books = @status.books
    end

    if params[:cover_id]
      @cover = Cover.find_by(id: params[:cover_id])
      @books = @cover.books
    end

    if params[:order]
      @books = @books.includes(:cover).order('covers.cover_type ASC')
    end

    @genres = Genre.all
    @covers = Cover.all
    @statuses = Status.all
  end

  def create
    @genre = Genre.find_by(id: params[:book][:genre_id])
    puts @genre
    @book = @genre.books.create!(book_params)
    @status = Status.find_by(id: params[:book][:status_id])
    @status.books << @book
    @cover = Cover.find_by(id: params[:book][:cover_id])
    @cover.books << @book
    respond_to do |format|
      format.js
    end
  end

  def edit
    @book = Book.find_by(id: params[:id])
    @genres = Genre.all
    @covers = Cover.all
    @statuses = Status.all
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
    params.require(:book).permit(:title, :author, :genre_id, :cover_id, :status_id)
  end
end
