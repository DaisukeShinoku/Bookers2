class BooksController < ApplicationController
    before_action :correct_user,   only: [:edit, :update]
	def new
		@book = Book.new
    end
    def create
    	@book = Book.new(book_params)
    	@book.user_id = current_user.id
   		if @book.save
        flash[:success] = 'You have creatad book successfully.'
    	redirect_to book_path(@book.id)
        else
            redirect_back fallback_location: root_path
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
    	if @book.update(book_params)
        flash[:success]="Book was successfully updated."
    	redirect_to book_path(@book.id)
        else
        render :edit
        end
    end
    def destroy
    	@book = Book.find(params[:id])
    	@book.destroy
    	redirect_to books_path
    end
    def correct_user
      @book = Book.find(params[:id])
      @user = @book.user
      if current_user != @user
      redirect_to books_path
      end
    end
    private

    	def book_params
    		params.require(:book).permit(:title, :body, :user_id)
    	end
end
