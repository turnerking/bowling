class GameChecker
  attr_accessor :game, :frames, :start_of_frame
  
  ILLEGAL_ENTRIES = /[^0-9X\/]/
  
  def initialize(game)
    @game = game
    @frames = 1
    @start_of_frame = true
  end
  
  def legal_game?
    @frames = 1
    @start_of_frame = true
    @game.scores.each do |score|
      return false if illegal_mark?(score.mark)
      return false if too_many_pins?(score)
      increment_values(score.mark, score.next_score)
    end
    return false if illegal_last_frame?(@game.scores[-3..-1])
    subtract_frames(@game.scores[-3..-1])
    return true
  end
  
  def illegal_mark?(mark)
    mark.match(ILLEGAL_ENTRIES) || improper_spare?(mark) || improper_strike?(mark)
  end
  
  def improper_spare?(mark)
    mark == "/" && @start_of_frame
  end
  
  def improper_strike?(mark)
    mark == "X" && !@start_of_frame
  end
  
  def too_many_pins?(score)
    return false if @start_of_frame || score.mark == "/"
    return true if (score.mark.to_i + score.prev_score.mark.to_i) > 9
    return false
  end
  
  def illegal_last_frame?(last_scores)
    return false if @start_of_frame
    return false if last_scores[0].mark == "X" && last_scores[1].mark == "X"
    return false if last_scores[1].mark == "/"
    return true
  end
  
  def subtract_frames(last_scores)
    if last_scores[1].mark == "/" || last_scores[2].mark == "/"
      #i.e. 3 / X, 3 / 2, X 4 /
      @frames += -1
    elsif last_scores[0].mark == "X" && last_scores[1].mark == "X" 
      #i.e. X X X, X X 4
      @frames += -2
    elsif last_scores[0].mark == "X"
      #This example is X 8 1, this could be the last frame or the last two frames, 
      #this checker will assume a ten frame game and act accordingly
      if @frames > 10
        @frames += -1
      else
        @frames += 0
      end
    else
      #i.e. open frame 8 1, 2 4
      @frames += 0
    end
  end
  
  def increment_values(mark, next_score)
    if @start_of_frame
      if(mark == "X" && next_score)
        @frames += 1
      else
        @start_of_frame = !@start_of_frame
      end
    else
      @frames += 1 if next_score
      @start_of_frame = !@start_of_frame
    end
  end    
end