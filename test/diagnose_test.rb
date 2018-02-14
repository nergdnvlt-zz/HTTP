require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'

require './lib/diagnose'

class DiagnosticTest < MiniTest::Test
  def setup
    @request = ['GET / HTTP/1.1',
                'Host: 127.0.0.1:9292',
                'Connection: keep-alive',
                'Cache-Control: no-cache',
                'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_2)',
                'Postman-Token: 4331415e-edea-a89a-9b02-21bccb082332',
                'Accept: */*',
                'Accept-Encoding: gzip, deflate, br',
                'Accept-Language: en-US,en;q=0.9']
  end

  def test_verb_method
    assert_equal 'GET', Diagnose.verb(@request)
  end

  def test_path_method
    assert_equal '/', Diagnose.path(@request)
  end

  def test_protocol_method
    result = Diagnose.protocol(@request)
    assert_equal 'HTTP/1.1', result
  end

  def test_host_method
    result = Diagnose.host(@request)
    assert_equal '127.0.0.1:9292', result
  end

  def test_port_method
    result = Diagnose.port(@request)
    assert_equal '9292', result
  end

  def test_accept_method
    result = Diagnose.accept(@request)
    assert_equal '*/*', result
  end

  def test_diagnostic
    expected = "Verb: GET
    Path: /
    Protocol: HTTP/1.1
    Host: 127.0.0.1:9292
    Port: 9292
    Origin: 127.0.0.1:9292
    Accept: */*"
    result = Diagnose.diagnostic(@request)
    assert_equal expected, result
  end
end
