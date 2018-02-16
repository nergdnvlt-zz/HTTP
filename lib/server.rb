require 'socket'
require './lib/path'

# Creates a server object
class Server
  attr_accessor :tcp_server

  def initialize
    @path = Path.new
    @client = nil
    @request_lines = []
    @server_loop = true
    @parser_output = ''
    @body = ''
    @guess = 0
  end

  def start
    tcp_server = TCPServer.new(9292)
    tcp_server.listen(1)
    while @server_loop
      @client = tcp_server.accept
      while_loop
      require "pry"; binding.pry
      parser
      printing
      @request_lines = []
    end
  end

  def while_loop
    while line = @client.gets and !line.chomp.empty?
      @request_lines << line.chomp
    end
    guess
  end

  def parser
    @parser_output = @path.verb_parser(@request_lines)
  end

  def guess
    guess = @client.read(100)
    @guess = guess.split[-2]
  end

  def headers
    output = @parser_output
    ['http/1.1 200 ok',
     "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
     'server: ruby',
     'content-type: text/html; charset=iso-8859-1',
     "content-length: #{output.length}\r\n\r\n"].join("\r\n")
     require "pry"; binding.pry
  end

  def printing
    puts @request_lines
    @client.puts headers
    @client.puts @parser_output
    @server_loop = false if @parser_output.include? 'Total'
    @client.close
  end
end
