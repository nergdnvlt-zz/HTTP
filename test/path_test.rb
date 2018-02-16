require './test/test_helper'

require './lib/path'

class PathParserTest < MiniTest::Test
  def setup
    @path = Path.new
    @request = ['GET / HTTP/1.1',
                'Host: 127.0.0.1:9292',
                'Connection: keep-alive',
                'Cache-Control: no-cache',
                'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X)',
                'Postman-Token: 4331415e-edea-a89a-9b02-21bccb082332',
                'Accept: */*',
                'Accept-Encoding: gzip, deflate, br',
                'Accept-Language: en-US,en;q=0.9']
  end

  def test_it_exists
    assert_instance_of Path, @path
  end

  def test_will_pass_argument
    # path = Path.new
    # request = ['GET / HTTP/1.1',
    #            'Host: 127.0.0.1:9292',
    #            'Connection: keep-alive',
    #            'Cache-Control: no-cache',
    #            'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X)',
    #            'Postman-Token: 4331415e-edea-a89a-9b02-21bccb082332',
    #            'Accept: */*',
    #            'Accept-Encoding: gzip, deflate, br',
    #            'Accept-Language: en-US,en;q=0.9']

    expected = "Verb: GET
    <br>Path: /
    <br>Protocol: HTTP/1.1
    <br>Host: 127.0.0.1:9292
    <br>Port: 9292
    <br>Origin: 127.0.0.1:9292
    <br>Accept: */*"
    result = @path.verb_parser(@request)
    assert_equal expected, result
  end

  def test_passed_hello
    request = ['GET /hello HTTP/1.1',
               'Host: 127.0.0.1:9292']
    result = @path.verb_parser(request)
    assert result.include? 'Hello'
  end

  def test_path_for_datetime
    request = ['GET /datetime HTTP/1.1',
               'Host: 127.0.0.1:9292']
    expected = Time.now.strftime('%H:%M%p on %A, %B %d, %Y')
    result = @path.verb_parser(request)

    assert_equal expected, result
  end

  def test_for_dictionary_known
    request = ['GET /word_search?word=hi HTTP/1.1',
               'Host: 127.0.0.1:9292']
    result = @path.verb_parser(request)

    assert_equal 'HI is a known word', result
  end

  def test_for_dictionary_unknown
    request = ['GET /word_search?word=afse HTTP/1.1',
               'Host: 127.0.0.1:9292']
    result = @path.verb_parser(request)

    assert_equal 'AFSE is not a known word', result
  end

  def test_for_shutdown
    request = ['GET /shutdown HTTP/1.1',
               'Host: 127.0.0.1:9292']
    result = @path.verb_parser(request).include?('Total')

    assert result
  end
end
