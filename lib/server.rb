require 'socket'

# Creates a server object
class Server
  def initialize
    @tcp_server = TCPServer.new(9292)
    @tcp_server.listen(1)
    @client = nil
    @count = 0
    @request_lines = []
  end

  def start
    loop do
      @client = @tcp_server.accept
      while_loop
      @count += 1
      response
      @client.close
      break if @count == 4
    end
  end

  def response
    puts request_lines
    response = '<pre>' + "Hello, World! (#{@count})\n\t#{diagnostic}" '</pre>'
    output = "<html><head></head><body>#{response}</body></html>"
    headers = ['http/1.1 200 ok',
               "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
               'server: ruby',
               'content-type: text/html; charset=iso-8859-1',
               "content-length: #{output.length}\r\n\r\n"].join("\r\n")
    @client.puts headers
    @client.puts output
  end

  def while_loop
    while line = @client.gets and !line.chomp.empty?
      @request_lines << line.chomp
    end
  end

  def diagnostic
    first_three = @request_lines[0].split
    verb = first_three[0]
    path = first_three[1]
    protocol = first_three[2]
    host = @request_lines[1].split[1]
    port = @request_lines[1].split(":")[2]
    accept = @request_lines[6].split[1]

    "Verb: #{verb}
    Path: #{path}
    Protocol: #{protocol}
    Host: #{host}
    Port: #{port}
    Origin: #{host}
    Accept: #{accept}"
  end
end
