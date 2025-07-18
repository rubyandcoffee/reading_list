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
    author = Author.new(author_params)
    if author.save
      render json: author, status: :created
    else
      render json: { errors: author.errors.full_messages }, status: :unprocessable_entity
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

  def import
    return redirect_to request.referer, notice: 'No file added' if params[:file].nil?
    return redirect_to request.referer, notice: 'Only CSV files allowed' unless params[:file].content_type == 'text/csv'

    CsvImportService.new.import_author(params[:file])

    redirect_to request.referer, notice: 'Successfully imported author'
  end

  private
    def set_author
      @author = Author.find(params[:id])
    end

    def author_params
      params.require(:author).permit(:forename, :surname, :nationality, :gender)
    end
end
