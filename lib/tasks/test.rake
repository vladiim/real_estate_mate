require 'rake/testtask'

namespace 'test' do

  desc 'runs interest tests'
  task :interest do
  	sh 'ruby -Itest test/interest/*_test.rb'
  end

  desc 'run scraper tests'
  task :scrapers do
  	sh 'ruby -Itest test/scrapers/**/*_test.rb'
  end

  desc 'run conversion tests'
  task :conversion do
  	sh 'ruby -Itest test/conversions/*_test.rb'
  end

  desc 'run website tests'
  task :websites do
    sh 'ruby -Itest test/websites/*_test.rb'
  end

  desc 'run all tests'
  task all: [:interest, :scrapers, :conversion, :websites]
end