require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'

require './lib/path_reaction'

class PathTest < MiniTest::Test
  def test_path_for_backslash
    assert_equal 'debug info', Path.route('/')
  end

  def test_path_for_hello
    assert_equal 'counter', Path.route('/hello')
  end

  def test_path_for_datetime
    assert_equal Time.now, Path.route('/datetime')
  end

  def test_for_shutdown
    assert_equal 'close client', Path.route('/shutdown')
  end

  # def test_diagnostic
  #   assert_equal 'string', Path.diagnostic
  # end
end
