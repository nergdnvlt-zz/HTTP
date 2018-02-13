require './lib/server.rb'
require './lib/diagnose'

module Path
  include Diagnose

  def self.route(request_lines)
    path = request_lines[0].split[1]
    if path == '/'
      Diagnose.diagnostic_string(request_lines)
    elsif path == '/hello'
      'counter'
    elsif path == '/datetime'
      'time'
    elsif path == '/shutdown'
      'close client'
    else
      'edge case'
    end
  end
end
