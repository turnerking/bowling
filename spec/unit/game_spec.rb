require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Game do

  describe "final score" do
    describe "in a 10 frame game" do
      it "is 300 on all strikes" do
        game = Game.new("X X X X X X X X X X X X")
        game.final_score.should == 300
      end
      
      it "is 299 on all strikes with 9 as last ball" do
        game = Game.new("X X X X X X X X X X X 9")
        game.final_score.should == 299
      end
      
      it "is 281 on all strikes with 2 7 as last two balls" do
        game = Game.new("X X X X X X X X X X 2 7")
        game.final_score.should == 281
      end
  
      it "is 90 on all 9's" do
        game = Game.new("9 0 9 0 9 0 9 0 9 0 9 0 9 0 9 0 9 0 9 0")
        game.final_score.should == 90
      end
  
      it "is 199 on spare/9's" do
        game = Game.new("9 / 9 / 9 / 9 / 9 / 9 / 9 / 9 / 9 / 9 / 9")
        game.final_score.should == 199
      end  
      
      it "is 145 on odd scores" do
        game = Game.new("0 / 1 / 2 / 3 / 4 / 5 / 6 / 7 / 8 / 9 / 0")
        game.final_score.should == 145
      end     
    end
  end
  
  describe "10 frames" do
    it "on all strikes" do
      game = Game.new("X X X X X X X X X X X X")
      game.legal?.should be_true
      game.frames.should == 10
    end
  
    it "on all 9's" do
      game = Game.new("9 0 9 0 9 0 9 0 9 0 9 0 9 0 9 0 9 0 9 0")
      game.legal?.should be_true
      game.frames.should == 10
    end
  
    it "on spare/9's" do
      game = Game.new("9 / 9 / 9 / 9 / 9 / 9 / 9 / 9 / 9 / 9 / 9")
      game.legal?.should be_true
      game.frames.should == 10
    end
  end


end