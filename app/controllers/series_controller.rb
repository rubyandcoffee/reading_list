class SeriesController < ApplicationController
  before_action :set_series, only: %i[ show edit update destroy ]

  def index
    series = Series.includes(:author)
    @sorted_series = series.sort_by { |books| Series.completed?(books) ? 0 : 1 }
  end

  def show
  end

  def new
    @series = Series.new
  end

  def edit
  end

  def create
    series = Series.new(series_params)
    if series.save
      render json: series, status: :created
    else
      render json: { errors: series.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    respond_to do |format|
      if @series.update(series_params)
        format.html { redirect_to series_url(@series), notice: "Series was successfully updated." }
        format.json { render :show, status: :ok, location: @series }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @series.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @series.destroy

    respond_to do |format|
      format.html { redirect_to series_index_url, notice: "Series was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def set_series
      @series = Series.find(params[:id])
    end

    def series_params
      params.require(:series).permit(:name, :author_id)
    end
end
