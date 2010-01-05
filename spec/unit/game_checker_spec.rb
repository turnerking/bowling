require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe GameChecker do
  
  it "raises error if no scores" do
    NotGame = Struct.new(:nothing) do
      include GameChecker
    end
    not_game = NotGame.new
    lambda do
      not_game.legal?
    end.should raise_error("Needs to have scores to check")
  end
  
  describe "legal game" do
    it "returns false if there is an illegal character" do
      Game.new("9 a").legal?.should be_false
    end
    
    it "returns false if there is a spare in the first ball" do
      Game.new("9 / /").legal?.should be_false      
    end
    
    it "returns false if there is a strike on the second ball" do
      Game.new("7 2 3 X").legal?.should be_false
    end
    
    it "returns false if there too many pins in a frame" do
      Game.new("9 / 7 4").legal?.should be_false
    end
    
    it "returns false if there is an illegal ending to the game" do
      Game.new("8 1 6").legal?.should be_false
    end
    
    it "returns true if there is an legal ending to the game" do
      Game.new("8 1 6 3").legal?.should be_true
    end
    
    it "returns true if there is an legal ending to the game" do
      Game.new("8 / 3").legal?.should be_true
    end
    
  end
end