require 'socket'

class Server
  def initialize
    @tcp_server = TCPServer.new(9292)
  end

  def start
    count = 0
    while true
      @client = @tcp_server.accept
      puts 'Ready for a request'
      request_lines = []
      # require "pry"; binding.pry
      while line = @client.gets and !line.chomp.empty?
        request_lines << line.chomp
      end

      puts 'Got this request:'
      puts request_lines.inspect

      puts 'Sending response.'
      # response = "<pre>" + request_lines.join("\n") + "</pre>"
      puts count
      output = "<html><head></head><body>Hello, World! (#{count})</body></html>"
      headers = ['http/1.1 200 ok',
                 "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
                 'server: ruby',
                 'content-type: text/html; charset=iso-8859-1',
                 "content-length: #{output.length}\r\n\r\n"].join("\r\n")
      @client.puts headers
      @client.puts output

      puts ['Wrote this response:', headers, output].join("\n")
      puts "\nResponse complete, exiting."
      count += 1
    end
  end

  def close
    @client.close
  end
end
