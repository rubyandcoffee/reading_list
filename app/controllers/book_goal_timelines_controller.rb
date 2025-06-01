class BookGoalTimelinesController < ApplicationController
  before_action :set_book_goal_timeline, only: %i[ show edit update destroy ]

  # GET /book_goal_timelines or /book_goal_timelines.json
  def index
    @book_goal_timelines = BookGoalTimeline.all
  end

  # GET /book_goal_timelines/1 or /book_goal_timelines/1.json
  def show
  end

  # GET /book_goal_timelines/new
  def new
    @book_goal = BookGoal.last
    @book_goal_timeline = BookGoalTimeline.new
  end

  # GET /book_goal_timelines/1/edit
  def edit
  end

  # POST /book_goal_timelines or /book_goal_timelines.json
  def create
    @book_goal_timeline = BookGoalTimeline.new(book_goal_timeline_params)

    respond_to do |format|
      if @book_goal_timeline.save
        format.html { redirect_to book_goal_timeline_url(@book_goal_timeline), notice: "Book goal timeline was successfully created." }
        format.json { render :show, status: :created, location: @book_goal_timeline }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @book_goal_timeline.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /book_goal_timelines/1 or /book_goal_timelines/1.json
  def update
    respond_to do |format|
      if @book_goal_timeline.update(book_goal_timeline_params)
        format.html { redirect_to book_goal_timeline_url(@book_goal_timeline), notice: "Book goal timeline was successfully updated." }
        format.json { render :show, status: :ok, location: @book_goal_timeline }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @book_goal_timeline.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /book_goal_timelines/1 or /book_goal_timelines/1.json
  def destroy
    @book_goal_timeline.destroy

    respond_to do |format|
      format.html { redirect_to book_goal_timelines_url, notice: "Book goal timeline was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book_goal_timeline
      @book_goal_timeline = BookGoalTimeline.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def book_goal_timeline_params
      params.require(:book_goal_timeline).permit(:book_goal_id, :week_one, :week_two, :week_three, :week_four)
    end
end
