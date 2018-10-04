class SourcebooksController < ApplicationController
  def index
    render json: { data: SourceBook.all.order(:title) }
  end
end
