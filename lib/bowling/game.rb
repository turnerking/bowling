class Game
  
  attr_accessor :scores, :game_checker
  
  def initialize(scores)
    @scores = []
    scores.split(" ").each do |score|
      @scores << Score.new(:mark => score)
    end
    for i in 0..(@scores.size-1)
      @scores[i].prev_score = @scores[i - 1]
      @scores[i].next_score = @scores[i + 1]
    end
    @game_checker = GameChecker.new(self)
  end
  
  def final_score
    @scores.inject(0) {|total, score| total + score.send(score.mark.to_sym)}
  end
  
  def legal?
    @game_checker.legal_game?
  end
end