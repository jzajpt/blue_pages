# encoding: utf-8

require 'permalink'
require 'blue_pages/localized_keys'

module BluePages

  class Engine < Rails::Engine
  end

  def self.setup
    yield self
  end

  mattr_accessor :route_prefix
  mattr_accessor :layout
  mattr_accessor :model_includes

end
