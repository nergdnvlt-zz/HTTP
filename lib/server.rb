require 'socket'
require './lib/path'

# Creates a server object
class Server
  include Path
  def initialize
    @tcp_server = TCPServer.new(9292)
    @tcp_server.listen(1)
    @client = nil
    @count = 0
    @request_lines = []
    @last_request = []
  end

  def start
    loop do
      @client = @tcp_server.accept
      while_loop
      @count += 1
      response
      @client.close
      @request_lines = []
      break if @count == 4
    end
  end

  def while_loop
    while line = @client.gets and !line.chomp.empty?
      @request_lines << line.chomp
    end
  end

  def parser
    last_request = @request_lines
    # @last_request << @request_lines
    # last_request = @last_request[-1]
    require "pry"; binding.pry
    Path.route(last_request)
  end

  def response
    puts @request_lines
    response = '<pre>'"#{parser}"'</pre>'
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
