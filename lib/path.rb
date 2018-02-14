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

  def dictionary(path)
    word = path
    require "pry"; binding.pry
    File.open('/usr/share/dict/words') do |file|
      file.each do |line|
        word[line.strip] = true
      end
    end
  end
end
