require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'

require './lib/server'

class ServerTest < MiniTest::Test
  def test_server_class
    server = Server.new

    assert_instance_of Server, server
  end

  def test_server_initializes_with_new_socket
    # server = Server.new
  end
end
