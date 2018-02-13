require './lib/server.rb'

# Determines the response based on path
module Path
  @request_lines = ['GET / HTTP/1.1',
                    'Host: 127.0.0.1:9292',
                    'Connection: keep-alive',
                    'Cache-Control: no-cache',
                    'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.132 Safari/537.36',
                    'Postman-Token: 4331415e-edea-a89a-9b02-21bccb082332',
                    'Accept: */*',
                    'Accept-Encoding: gzip, deflate, br',
                    'Accept-Language: en-US,en;q=0.9']

  def self.route(path)
    if path == '/'
      'debug info'
    elsif path == '/hello'
      'counter'
    elsif path == '/datetime'
      Time.now
    elsif path == '/shutdown'
      'close client'
    else
      'edge case'
    end
  end

  def self.diagnostic
    # request_lines = @request_lines
    "Verb: #{@request_lines[0].split[0]}
    Path: #{@request_lines[0].split[1]}
    Protocol: #{@request_lines[0].split[2]}
    Host: #{@request_lines[1].split[1]}
    Port: #{@request_lines[1].split(":")[2]}
    Origin: #{@request_lines[1].split[1]}
    Accept: #{@request_lines[6].split[1]}"
  end

  def response
    response = '<pre>' + "Hello, World! (#{@count})\n#{diagnostic}" '</pre>'
    output = "<html><head></head><body>#{response}</body></html>"
    headers = ['http/1.1 200 ok',
               "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
               'server: ruby',
               'content-type: text/html; charset=iso-8859-1',
               "content-length: #{output.length}\r\n\r\n"].join("\r\n")
    @client.puts headers
    @client.puts output
  end
  # def evaluate
  # end
  #
  # def root
  # end
  #
  # def hello
  # end
  #
  # def datetime
  # end
  #
  # def shutdown
  # end
end
