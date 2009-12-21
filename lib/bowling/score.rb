class Score
  attr_accessor :prev_score, :next_score, :mark
  
  def initialize(params = {})
    @mark = params[:mark] || "0"
    @prev_score = params[:prev_score]
    @next_score = params[:next_score]
  end
  
  def amount
    case @mark 
    when "X" then 10
    when "/" then 10 - @prev_score.amount
    else @mark.to_i
    end
  end
  
  def X
    (last_score? || second_to_last_score?) ? 0 : (10 + next_score.amount + next_score.amount)
  end
  
  def /
    10 - prev_score.amount + (last_score? ? 0 : next_score.amount)
  end
  
  def method_missing(name, *args, &block)
    return name.to_s.to_i if name.to_s.match(/^[0-9]$/)
    super(name, *args, &block)
  end
  
private
  
  def last_score?
    next_score.nil?
  end
  
  def second_to_last_score?
    next_score.next_score.nil?
  end

end