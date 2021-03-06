class Api::V1::TournamentsController < ApplicationController

  before_action :set_tournament, only: %i[ show update destroy ]

  # GET /tournaments
  def index
    if params[:date]
      date = Date.parse(params[:date])
      @tournaments = Tournament.where(date: date.all_day)
    else
      @tournaments = Tournament.all.order(date: :desc)
    end
    render json: @tournaments
  end

  # GET /tournaments/1
  def show
    render json: @tournament
  end

  # POST /tournaments
  def create
    @tournament = Tournament.new(tournament_params)

    if @tournament.save
      render json: @tournament, status: :created, location: api_v1_tournaments_path(@tournament)
    else
      render json: @tournament.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /tournaments/1
  def update
    if @tournament.update(tournament_params)
      render json: @tournament
    else
      render json: @tournament.errors, status: :unprocessable_entity
    end
  end

  # DELETE /tournaments/1
  def destroy
    TournamentPlayer.delete_by(tournament_id: params[:id])
    @tournament.destroy
    render json: {}
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tournament
      @tournament = Tournament.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def tournament_params
      params.require(:tournament).permit(:id, :name, :course_name, :date)
    end
end
