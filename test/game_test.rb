require './test/test_helper'

require './lib/game'

class GameTest < MiniTest::Test
  def setup
    @game = Game.new
  end

  def test_it_exists
    assert_instance_of Game, @game
  end

  def test_generates_random
    result = (0..100).to_a.include? @game.random_number
    assert result
  end
end
