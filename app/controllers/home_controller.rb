class HomeController < ApplicationController
  def index
    @teams = Team.all.sort_by { |k| sts = k.stats params[:week]; [sts["points"], sts["average"]] }.reverse!
    @tours = Match.order("week DESC").take
    current_week = params[:week] ? params[:week] : @tours.week
    @matches = Match.where("week = :week", {week: current_week})
    @teams.each {|team| team.stats(current_week)["win"] = 5 }
  end
end
