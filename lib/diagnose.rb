# Puts together diagnostic string
module Diagnose
  def self.diagnostic(request)
    "Verb: #{verb(request)}
    Path: #{path(request)}
    Protocol: #{protocol(request)}
    Host: #{host(request)}
    Port: #{port(request)}
    Origin: #{host(request)}
    Accept: #{accept(request)}"
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
    request[6].split[1]
  end
end
