require File.expand_path(File.dirname(__FILE__) + '/game_checker')

class Game
  include GameChecker
  
  attr_accessor :scores
  
  def initialize(scores)
    @scores = []
    scores.split(" ").each do |score|
      @scores << Score.new(:mark => score)
    end
    for i in 0..(@scores.size-1)
      @scores[i].prev_score = @scores[i - 1]
      @scores[i].next_score = @scores[i + 1]
    end
  end
  
  def final_score
    @scores.inject(0) {|total, score| total + score.send(score.mark.to_sym)}
  end
end