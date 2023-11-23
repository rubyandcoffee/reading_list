class AuthorsController < ApplicationController
  before_action :set_author, only: %i[ show edit update destroy ]

  def index
    @q = Author.ransack(params[:q])
    @q.sorts = 'forename asc' if @q.sorts.empty?
    @authors = @q.result.paginate(page: params[:page], per_page: 20)
  end

  def show
  end

  def new
    @author = Author.new
  end

  def edit
  end

  def create
    @author = Author.new(author_params)

    respond_to do |format|
      if @author.save
        format.html { redirect_to new_book_path(params[:book]), notice: "#{@author.full_name} has been added" }
        format.json { render :show, status: :created, location: @author }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @author.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @author.update(author_params)
        format.json { render inline: "location.reload();" }
      else
        # TODO: This will return an error and isn't handled properly
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @author.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @author.destroy

    respond_to do |format|
      format.json { render inline: "location.reload();" }
    end
  end

  private
    def set_author
      @author = Author.find(params[:id])
    end

    def author_params
      params.require(:author).permit(:forename, :gender, :nationality, :surname)
    end
end
