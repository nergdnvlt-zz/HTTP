require 'faraday'
require './test/test_helper'

require './lib/server'

class ServerTest < MiniTest::Test
  # def test_default_path
  #   request = Faraday.get('http://127.0.0.1:9292/')
  #   assert request.body.include?('Verb')
  # end
  #
  # def test_hello_world_path
  #   request = Faraday.get('http://127.0.0.1:9292/hello')
  #   assert request.body.include?('Hello')
  # end
  #
  # def test_date_path
  #   request = Faraday.get('http://127.0.0.1:9292/datetime')
  #   assert request.body.include?('2018')
  # end
end
