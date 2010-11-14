# encoding: utf-8

module BluePages

  class Engine < Rails::Engine
  end

  def self.setup
    yield self
  end

  mattr_accessor :route_prefix

end
