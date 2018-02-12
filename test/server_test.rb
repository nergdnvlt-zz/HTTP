require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'

require './lib/server'

class ServerTest < MiniTest::Test
  def test_count_method
    server = Server.new
    expected = server.count_response

    assert_equal 1, expected
  end

  def test_initial_terminal_method
    server = Server.new
  end
end
