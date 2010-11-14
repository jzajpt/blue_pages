# require 'rake'
# require 'rake/testtask'
# require 'rake/rdoctask'
# 
# desc 'Default: run unit tests.'
# task :default => :test
# 
# desc 'Test the pages plugin.'
# Rake::TestTask.new(:test) do |t|
#   t.libs << 'lib'
#   t.libs << 'test'
#   t.pattern = 'test/**/*_test.rb'
#   t.verbose = true
# end
# 
# desc 'Generate documentation for the pages plugin.'
# Rake::RDocTask.new(:rdoc) do |rdoc|
#   rdoc.rdoc_dir = 'rdoc'
#   rdoc.title    = 'Pages'
#   rdoc.options << '--line-numbers' << '--inline-source'
#   rdoc.rdoc_files.include('README')
#   rdoc.rdoc_files.include('lib/**/*.rb')
# end

begin
  require "jeweler"
  Jeweler::Tasks.new do |gem|
    gem.name = "blue_pages"
    gem.summary = "Pages Engine for Rails 3"
    gem.files = Dir["{lib}/**/*", "{config}/**/*"]
    # other fields that would normally go in your gemspec
    # like authors, email and has_rdoc can also be included here
  end
rescue
  puts "Jeweler or one of its dependencies is not installed."
end
