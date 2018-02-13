require './lib/diagnose'

module Path
  include Diagnose
  @count = 0

  def self.route(request_lines)
    # server.count = 0
    # total_count = 0
    path = request_lines[0].split[1]
    if path == '/'
      Diagnose.diagnostic_string(request_lines)
    elsif path == '/hello'
      @count += 1
      "Hello World (#{@count})"
    elsif path == '/datetime'
      'time'
    elsif path == '/shutdown'
      'close client'
    else
      'edge case'
    end
  end
end
