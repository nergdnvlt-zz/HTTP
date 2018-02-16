require './lib/diagnose'
require './lib/game'

# Evaluates path for output
class Path
  include Diagnose

  def initialize
    @game = Game.new
    @count = 0
    @total_count = 0
    @path = ''
    @word = ''
  end

  def verb_parser(request_lines)
    verb = request_lines[0].split[0]
    @path = request_lines[0].split[1]
    @word = @path.split('=')[1]
    @total_count += 1
    return route(request_lines) if verb == 'GET'
    return game_post if verb == 'POST'
  end

  def route(request_lines)
    return Diagnose.diagnostic(request_lines) if @path == '/'
    return hello_world if @path == '/hello'
    return Diagnose.time if @path == '/datetime'
    return Diagnose.shutdown(@total_count) if @path == '/shutdown'
    return Diagnose.dictionary(@word) if @path.include? '/word_search'
    return game_getter if @path == '/game'
  end

  def hello_world
    @count += 1
    "Hello World (#{@count})"
  end

  def game_post
    if @path == '/start_game'
      @game.start
    elsif @path == 'game'
      @game
    end
  end

  def game_getter
    @game.results
  end
end
