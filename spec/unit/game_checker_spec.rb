require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe GameChecker do
  
  describe "legal game" do
    it "returns false if there is an illegal_game character" do
      GameChecker.new(Game.new("9 a")).legal_game?.should be_false
    end
    
    it "returns false if there is a spare in the first ball" do
      GameChecker.new(Game.new("9 / /")).legal_game?.should be_false      
    end
    
    it "returns false if there is a strike on the second ball" do
      GameChecker.new(Game.new("7 2 3 X")).legal_game?.should be_false
    end
    
    it "returns false if there too many pins in a frame" do
      GameChecker.new(Game.new("9 / 7 4")).legal_game?.should be_false
    end
    
    it "returns false if there is an illegal_game ending to the game" do
      GameChecker.new(Game.new("8 1 6")).legal_game?.should be_false
    end
    
    it "returns true if there is an legal_game ending to the game" do
      GameChecker.new(Game.new("8 1 6 3")).legal_game?.should be_true
    end
    
  end
end