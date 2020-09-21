class BooksController < ApplicationController 
    def index 
        @books = Book.all
    end 

    def show 
        @book = Book.find(params[:id])
    end

    def new
        @book = Book.new
    end
    
    def create
        @book = Book.new(book_params)
        if @book.save
            redirect_to @book
        else 
            render :new
        end
    end 

private 
    def book_params
        params.require(:book).permit(:title, :author, :description, :image_url, :publication_date, :price)
    end 
end  

def edit 
    @book = Book.find(params[:id])
    before_action :authenticate_user!, except: [:index, :show]
end

def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
        redirec_to @book
    else 
        render :edit
    end
    before_action :authenticate_user!, except: [:index, :show]
end 

def destroy
    book = Book.find(params[:id])
    book.destroy

    flash[:notice] = "El libro ha sido eliminado exitosamente"
    redirect_to books_path 
    before_action :authenticate_user!, except: [:index, :show]
end 