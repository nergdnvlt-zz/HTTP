require './lib/diagnose'
require './lib/game'

# Evaluates path for output
class Path
  include Diagnose

  def initialize
    @count = 0
    @total_count = 0
    @path = ''
  end

  def verb_parser(request_lines)
    verb = request_lines[0].split[0]
    @path = request_lines[0].split[1]
    @total_count += 1
    return route(request_lines) if verb == 'GET'
    return game(request_lines) if verb == 'POST'
  end

  def route(request_lines)
    return Diagnose.diagnostic(request_lines) if @path == '/'
    return hello_world if @path == '/hello'
    return time if @path == '/datetime'
    return shutdown if @path == '/shutdown'
    return dictionary if @path.include? '/word_search'
    return game_getter if @path == '/game'
  end

  def hello_world
    @count += 1
    "Hello World (#{@count})"
  end

  def shutdown
    "Total Requests: #{@total_count}"
  end

  def time
    Time.now.strftime('%H:%M%p on %A, %B %d, %Y')
  end

  def dictionary
    word = @path.split('=')[1]
    words = File.read('/usr/share/dict/words')
    search = if words.include?(word.downcase)
               true
             else
               false
             end
    print_word = word.upcase
    return "#{print_word} is a known word" if search
    "#{print_word} is not a known word"
  end

  def game(request_lines)
    if @path == '/start_game'
      @game = Game.new
      @game.start
    elsif @path == 'game'
      @game
    end
  end

  def game_getter
    @game.results
  end
end
