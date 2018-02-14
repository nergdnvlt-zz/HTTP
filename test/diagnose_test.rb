require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'

require './lib/diagnose'

class DiagnosticTest < MiniTest::Test
  def test_diagnostic
    request_lines = ['GET / HTTP/1.1',
                     'Host: 127.0.0.1:9292',
                     'Connection: keep-alive',
                     'Cache-Control: no-cache',
                     'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_2)',
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
    result = Diagnose.diagnostic(request_lines)
    assert_equal expected, result
  end
end
