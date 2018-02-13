require './lib/path_parser.rb'

module Diagnose
  def self.diagnostic_string(request)
    "Verb: #{verb_variable(request)}
    Path: #{path_variable(request)}
    Protocol: #{protocol_variable(request)}
    Host: #{host_variable(request)}
    Port: #{port_variable(request)}
    Origin: #{host_variable(request)}
    Accept: #{accept_variable(request)}"
  end

  def self.verb_variable(request)
    request[0].split[0]
  end

  def self.path_variable(request)
    request[0].split[1]
  end

  def self.protocol_variable(request)
    request[0].split[2]
  end

  def self.host_variable(request)
    request[1].split[1]
  end

  def self.port_variable(request)
    request[1].split(':')[2]
  end

  def self.accept_variable(request)
    request[6].split[1]
  end
end
