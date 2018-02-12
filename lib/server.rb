require 'socket'

class Server
  def initialize
    @tcp_server = TCPServer.new(9292)
    @request_lines = []
    @count = 1
  end

  def start
    @count = 1
    while true
      @client = @tcp_server.accept
      puts 'Ready for a request'
      while line = @client.gets and !line.chomp.empty?
        @request_lines << line.chomp
      end
      content_output
      @count += 1
      @client.close
    end
  end

  def content_output
    puts 'Got this request:'
    puts @request_lines.inspect

    puts 'Sending response.'
    # response = "<pre>" + request_lines.join("\n") + "</pre>"
    puts @count
    output = "<html><head></head><body>Hello, World! (#{@count})</body></html>"
    headers = ['http/1.1 200 ok',
               "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
               'server: ruby',
               'content-type: text/html; charset=iso-8859-1',
               "content-length: #{output.length}\r\n\r\n"].join("\r\n")
    @client.puts headers
    @client.puts output

    puts ['Wrote this response:', headers, output].join("\n")
    puts "\nResponse complete, exiting."
  end

  def while_loop
  end
  
  def close
  end
end
