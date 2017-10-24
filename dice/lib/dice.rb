class Roll
  attr_reader :dice

  def initialize(dice)
    @dice = dice
  end

  def score
    return 0 if dice.empty?
    dice_values = []
    dice.each do |die|
      dice_values << scores(die)
    end
    dice_values.inject(:+) + bonus_score
  end

  private
  def scores(die)
    {1 => 100, 5 => 50, 2 => 0, 3 => 0, 4 => 0, 6 => 0}[die]
  end

  def bonus_score
   triple = dice.select { |die| dice.count(die) > 2 }
   if triple[0] == 1
     700
   elsif triple[0] == 5
     350
   elsif triple == []
     0
   else
     triple[0] * 100
   end
  end
end

def score(dice)
  Roll.new(dice).score
end
