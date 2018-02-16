# Code for the game pathway
class Game
  attr_reader :random_number

  def initialize
    @random_number = rand(1..100)
  end

  def start
    'Good Luck'
  end
end
