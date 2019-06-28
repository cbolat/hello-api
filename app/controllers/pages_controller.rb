class PagesController < ApplicationController
  # app/controllers/items_controller.rb

    before_action :set_book
    before_action :set_book_page, only: [:show, :update, :destroy]

    # GET /books/:book_id/pages
    def index
      json_response(@book.pages)
    end

    # GET /books/:book_id/pages/:id
    def show
      json_response(@page)
    end

    # POST /books/:book_id/pages
    def create
      @book.pages.create!(page_params)
      json_response(@book, :created)
    end

    # PUT /books/:book_id/pages/:id
    def update
      @page.update(page_params)
      head :no_content
    end

    # DELETE /books/:book_id/pages/:id
    def destroy
      @page.destroy
      head :no_content
    end

    private

    def page_params
      params.permit(:title, :created_by)
    end

    def set_book
      @book = Book.find(params[:book_id])
    end

    def set_book_page
      @page = @book.pages.find_by!(id: params[:id]) if @book
    end

end
