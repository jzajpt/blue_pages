# encoding: utf-8

require 'rubygems'
require 'rake'
require 'rake/rdoctask'


begin
  require "jeweler"
  Jeweler::Tasks.new do |gem|
    gem.name = "blue_pages"
    gem.summary = "Pages Engine for Rails 3"
    gem.description = "Pages engine handles cms-like pages."
    gem.email = "jzajpt@blueberry.cz"
    gem.homepage = "http://github.com/jzajpt/blue_pages"
    gem.authors = ["Jiří Zajpt"]
    gem.files = Dir["{lib}/**/*", "{config}/**/*"]
    # other fields that would normally go in your gemspec
    # like authors, email and has_rdoc can also be included here
  end
  Jeweler::GemcutterTasks.new
rescue
  puts "Jeweler or one of its dependencies is not installed."
end


desc 'Generate documentation for the pages plugin.'
Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'Pages'
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include('README')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

