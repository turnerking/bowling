require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Score do
  it "returns 30 when asked the score for a X followed by X X" do
    @score1 = Score.new(:mark => "X")
    @score2 = Score.new(:mark => "X", :prev_score => @score1)
    @score3 = Score.new(:mark => "X", :prev_score => @score2)
    @score4 = Score.new(:mark => "X", :prev_score => @score3)
    @score1.next_score = @score2
    @score2.next_score = @score3
    @score3.next_score = @score4
    
    @score1.X.should == 30
    
  end
end