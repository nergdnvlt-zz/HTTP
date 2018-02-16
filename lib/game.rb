# Code for the game pathway
class Game
  attr_reader :random_number

  def initialize
    @random_number = rand(1..100)
    @user_guess    = 0
    @tries         = 0
    @result        = ''
  end

  def start
    'Good Luck'
  end

  def guess(user_guess)
    @tries += 1
    @user_guess = user_guess.to_i
    return @result = 'Correct!' if @user_guess == @random_number
    return @result = 'Nope, too high!' if @user_guess > @random_number
    return @result = 'Sorry, too low!' if @user_guess < @random_number
  end

  def results
    "#{@result} with #{@tries} attempts!"
  end
end
