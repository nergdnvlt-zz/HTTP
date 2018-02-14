require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'

require './lib/path'

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

  def test_passed_hello
    request = ['GET /hello HTTP/1.1',
               'Host: 127.0.0.1:9292']
    assert_equal "Hello World (1)", Path.route(request)
  end

  def test_path_for_datetime
    request = ['GET /datetime HTTP/1.1',
               'Host: 127.0.0.1:9292']
    expected = Time.now.to_s
    result = Path.route(request)

    assert_equal expected, result
  end

  def test_for_shutdown
    request = ['GET /shutdown HTTP/1.1',
               'Host: 127.0.0.1:9292']
    result = Path.route(request).include?('Total')

    assert result
  end
end
