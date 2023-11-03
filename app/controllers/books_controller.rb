class BooksController < ApplicationController


  def show
    @book = Book.find(params[:id])
    @book_new=Book.new
    @user=current_user
    @post_comment= PostComment.new
  end

  def index
    # tag_idがセットされていたらTagから関連づけられたbooksを呼び指定がなければ全ての投稿を表示
    @books = params[:tag_id].present? ? Tag.find(params[:tag_id]).books : Book.all
    @book=Book.new
  
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id

    if @book.save
      redirect_to book_path(@book), notice: "You have created book successfully."
    else
      @books = Book.all
      render 'index'
    end
  end

  def edit
    @book = Book.find(params[:id])
    if @book.user!=current_user
      redirect_to books_path
    end
  end

  def update
    @book = Book.find(params[:id])
    @books=Book.all
    if @book.update(book_params)
      redirect_to book_path(@book.id), notice: "You have updated book successfully."
    else

       render :edit
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body, tag_ids: [])
  end


end
