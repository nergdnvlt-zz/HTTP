require './lib/diagnose'

# Evaluates path for output
module Path
  include Diagnose
  @count = 0
  @total_count = 0

  def self.route(request_lines)
    @total_count += 1
    path = request_lines[0].split[1]
    return Diagnose.diagnostic(request_lines) if path == '/'
    return hello_world if path == '/hello'
    return Time.now.to_s if path == '/datetime'
    return shutdown if path == '/shutdown'
    return dictionary(path) if path.include? '/word_search'
  end

  def self.hello_world
    @count += 1
    "Hello World (#{@count})"
  end

  def self.shutdown
    "Total Requests: #{@total_count}"
  end

  def self.dictionary(path)
    word = path.split('=')[1]
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
end
