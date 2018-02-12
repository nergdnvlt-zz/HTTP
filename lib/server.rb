require 'socket'

class Server
  def initialize
    @tcp_server = TCPServer.new(9292)
    @tcp_server.listen(1)
    @client = nil
    @count = 0
  end

  def start
    loop do
      @client = @tcp_server.accept
      @count += 1
      response
      @client.close
      break if count == 4
    end
  end

  def response
    response = '<pre>' + "Hello, World! (#{@count})" + '</pre>'
    output = "<html><head></head><body>#{response}</body></html>"
    headers = ['http/1.1 200 ok',
               "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
               'server: ruby',
               'content-type: text/html; charset=iso-8859-1',
               "content-length: #{output.length}\r\n\r\n"].join("\r\n")
    @client.puts headers
    @client.puts output
  end
end
