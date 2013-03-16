require 'rake/testtask'

namespace 'test' do

  desc 'runs interest tests'
  task :interest do
  	sh 'ruby -Itest test/interest/*_test.rb'
  end

  desc 'run scraper tests'
  task :scrapers do
  	sh 'ruby -Itest test/scrapers/*_test.rb'
  end

  desc 'run conversion tests'
  task :conversion do
  	sh 'ruby -Itest test/conversions/*_test.rb'
  end

  desc 'run all tests'
  task all: [:interest, :scrapers, :conversion]
end

desc 'run interest tests'
task :test do
  Rake::TestTask.new do |t|
  	t.libs.push "#{Dir.pwd}/lib"
  	t.test_files = FileList["#{Dir.pwd}/test/interest/*_test.rb"]
  	t.verbose = true
  end
end

