require './lib/diagnose'

module Path
  include Diagnose
  @count = 0
  @total_count = 0

  def self.route(request_lines)
    @total_count += 1
    path = request_lines[0].split[1]
    if path == '/'
      Diagnose.diagnostic_string(request_lines)
    elsif path == '/hello'
      @count += 1
      "Hello World (#{@count})"
    elsif path == '/datetime'
      Time.now
    elsif path == '/shutdown'
      "Total Requests: #{total_count}"
    end
  end
end
