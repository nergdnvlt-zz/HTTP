# Puts together diagnostic string
module Diagnose
  def self.diagnostic(request)
    "Verb: #{verb(request)}
    <br>Path: #{path(request)}
    <br>Protocol: #{protocol(request)}
    <br>Host: #{host(request)}
    <br>Port: #{port(request)}
    <br>Origin: #{host(request)}
    <br>Accept: #{accept(request)}"
  end

  def self.verb(request)
    request[0].split[0]
  end

  def self.path(request)
    request[0].split[1]
  end

  def self.protocol(request)
    request[0].split[2]
  end

  def self.host(request)
    request[1].split[1]
  end

  def self.port(request)
    request[1].split(':')[2]
  end

  def self.accept(request)
    return '' if request[6].class == NilClass
    request[6].split[1]
  end
end
