class MatchupsController < ApplicationController

  def new
    @competitors = Competitor.all
    @types = MatchupType.all
    @matchup = Matchup.new
  end

  def index
    @matchups = Matchup.all
  end

  def create
    @competitor1 = Competitor.find(competitor1)
    @competitor2 = Competitor.find(competitor2)
    @matchup_type = MatchupType.find(matchup_type)

    if same_competitors? #|| !valid_date?
      redirect_to new_matchup_path
    else
      @matchup = Matchup.new(deadline: DateTime.new(2017, 5, 21), matchup_type_id: @matchup_type.id)
      @matchup.name = "#{@competitor1.name} VS #{@competitor2.name}"
      @matchup.competitors = [@competitor1, @competitor2]
      @matchup.save
      redirect_to @matchup
    end
    #@matchup = Matchup.new

  end

  def show
    @matchup = Matchup.find(params[:id])
  end

  def destroy
    @matchup = Matchup.find(params[:id])
    @matchup.destroy
    redirect_to matchups_path
  end

  def create_random_matchup
    @random_matchup = RandomMatchupGenerator.new
    @random_matchup.randomize
    @matchup = @random_matchup.instance_variable_get("@matchup")
    @matchup.save
    redirect_to @matchup
  end

  private

  def competitor1
    params[:competitor1]
  end

  def competitor2
    params[:competitor2]
  end

  def matchup_type
    params[:matchup_type]
  end

  # def valid_date?
  #
  #   if @deadline && @deadline > DateTime.now
  #     return true
  #   else
  #     flash[:date] = "You've entered invalid date!"
  #   end
  #
  # end

  def same_competitors?
    if competitor1 == competitor2
      flash[:failed_creation] = "You cannot pick the same competitor for a matchup."
    end
  end


end
