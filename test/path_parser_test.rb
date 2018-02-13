require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'

require './lib/path_parser'

class PathParserTest < MiniTest::Test
  def test_will_pass_argument
    request = ['GET / HTTP/1.1',
               'Host: 127.0.0.1:9292',
               'Connection: keep-alive',
               'Cache-Control: no-cache',
               'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X)',
               'Postman-Token: 4331415e-edea-a89a-9b02-21bccb082332',
               'Accept: */*',
               'Accept-Encoding: gzip, deflate, br',
               'Accept-Language: en-US,en;q=0.9']

    expected = 'Verb: GET
    Path: /
    Protocol: HTTP/1.1
    Host: 127.0.0.1:9292
    Port: 9292
    Origin: 127.0.0.1:9292
    Accept: */*'

    assert_equal expected, Path.route(request)
  end

  # def test_passed_hello
  #   request = ['GET /hello HTTP/1.1',
  #              'Host: 127.0.0.1:9292']
  #   path = Path.new(request)
  #
  #   assert_equal 'counter', path.route
  # end

  # def test_path_for_datetime
  #   request = ['GET /datetime HTTP/1.1',
  #              'Host: 127.0.0.1:9292']
  #   path = Path.new(request)
  #
  #   assert_equal 'time', path.route
  # end

  # def test_for_shutdown
  #   request = ['GET /shutdown HTTP/1.1',
  #              'Host: 127.0.0.1:9292']
  #   path = Path.new(request)
  #
  #   assert_equal 'close client', path.route
  # end



  # def test_will_pass_argument
  #   request = ['GET / HTTP/1.1',
  #              'Host: 127.0.0.1:9292',
  #              'Connection: keep-alive',
  #              'Cache-Control: no-cache',
  #              'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X)',
  #              'Postman-Token: 4331415e-edea-a89a-9b02-21bccb082332',
  #              'Accept: */*',
  #              'Accept-Encoding: gzip, deflate, br',
  #              'Accept-Language: en-US,en;q=0.9']
  #   path = Path.new(request)
  #
  #   expected = 'Verb: GET
  #   Path: /
  #   Protocol: HTTP/1.1
  #   Host: 127.0.0.1:9292
  #   Port: 9292
  #   Origin: 127.0.0.1:9292
  #   Accept: */*'
  #
  #   assert_equal expected, path.route
  # end
  #
  # def test_passed_hello
  #   request = ['GET /hello HTTP/1.1',
  #              'Host: 127.0.0.1:9292']
  #   path = Path.new(request)
  #
  #   assert_equal 'counter', path.route
  # end
  #
  # def test_path_for_datetime
  #   request = ['GET /datetime HTTP/1.1',
  #              'Host: 127.0.0.1:9292']
  #   path = Path.new(request)
  #
  #   assert_equal 'time', path.route
  # end
  #
  # def test_for_shutdown
  #   request = ['GET /shutdown HTTP/1.1',
  #              'Host: 127.0.0.1:9292']
  #   path = Path.new(request)
  #
  #   assert_equal 'close client', path.route
  # end
end
