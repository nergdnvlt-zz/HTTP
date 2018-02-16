require './lib/response'
require './lib/game'

# Evaluates path for output
class Path
  attr_accessor :path,
                :test_guess

  include Response

  def initialize
    @client = ''
    @test_guess = 0
    @game = Game.new
    @guess = 0
    @count = 0
    @total_count = 0
    @path = ''
    @word = ''
  end

  def verb_parser(request_lines, client=nil)
    @client = client
    verb = request_lines[0].split[0]
    @path = request_lines[0].split[1]
    @word = @path.split('=')[1]
    @total_count += 1
    return route(request_lines) if verb == 'GET'
    return game_post if verb == 'POST'
  end

  def route(request_lines)
    return Response.diagnostic(request_lines) if @path == '/'
    return Response.hello_world(@count += 1) if @path == '/hello'
    return Response.time if @path == '/datetime'
    return Response.shutdown(@total_count) if @path == '/shutdown'
    return Response.dictionary(@word) if @path.include? '/word_search'
    return game_getter if @path == '/game'
  end

  def game_post
    if @path == '/start_game'
      @game.start
    elsif @path == '/game'
      return @game.guess(@test_guess) if @test_guess.class == Integer
      user_guess
      @game.guess(@guess)
    end
  end

  def game_getter
    @game.results
  end

  def user_guess
    guess = @client.read(100)
    @guess = guess.split[-2]
  end
end
