class BooksController < ApplicationController
	def new
		@book = Book.new
    end
    def create
    	@book = Book.new(book_params)
    	@book.user_id = current_user.id
   		if @book.save
    	redirect_to book_path(@book.id)
        else
            @books = Book.all
            @user = current_user
            render action: :index
    # indexのアクションを無視してインデックスに行く（再定義した理由）／renderの上に書くこと/newもコピペするとミスデータが上書きされる
        end
    end
    def index
    	@books = Book.all
        @user = current_user
    end
    def show
    	@book = Book.find(params[:id])
        @user = @book.user
    end
    def edit
    	@book = Book.find(params[:id])
    end
    def update
    	@book = Book.find(params[:id])
    	@book.update(book_params)
    	redirect_to book_path(@book.id)
    end
    def destroy
    	@book = Book.find(params[:id])
    	@book.destroy
    	redirect_to books_path
    end
    private

    	def book_params
    		params.require(:book).permit(:title, :body, :user_id)
    	end
end
