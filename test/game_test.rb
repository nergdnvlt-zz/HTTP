require './test/test_helper'

require './lib/game'

class GameTest < MiniTest::Test
  def setup
    @game = Game.new(88)
  end

  def test_it_exists
    assert_instance_of Game, @game
  end

  def test_generates_random
    game = Game.new
    result = (0..100).to_a.include? game.random_number
    assert result
  end

  def test_guesses_too_high
    result = @game.guess(99)
    assert_equal 'Nope, too high!', result
    result2 = @game.guess(90)
    assert_equal 'Nope, too high!', result2
  end

  def test_guesses_too_low
    result = @game.guess(8)
    assert_equal 'Sorry, too low!', result
    result2 = @game.guess(25)
    assert_equal 'Sorry, too low!', result2
  end

  def test_guess_correct
    result = @game.guess(88)
    assert_equal 'Correct!', result
  end

  def test_other_correct
    game = Game.new(50)
    result = game.guess(50)
    assert_equal 'Correct!', result
  end

  def test_results_too_high
    game = Game.new(66)
    result = game.guess(99)
    assert_equal 'Nope, too high!', result
    assert_equal 'Nope, too high! With 1 attempt!', game.results
    result2 = game.guess(90)
    assert_equal 'Nope, too high!', result2
    assert_equal 'Nope, too high! With 2 attempts!', game.results
  end

  def test_results_low
    game = Game.new(38)
    result = game.guess(12)
    assert_equal 'Sorry, too low!', result
    assert_equal 'Sorry, too low! With 1 attempt!', game.results
    result2 = game.guess(18)
    assert_equal 'Sorry, too low!', result2
    assert_equal 'Sorry, too low! With 2 attempts!', game.results
  end
end
