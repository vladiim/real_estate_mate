require 'rake/testtask'

desc 'run all tests'
task :test do
  Rake::TestTask.new do |t|
  	t.libs.push "#{Dir.pwd}/lib"
  	t.test_files = FileList["#{Dir.pwd}/test/**/*_test.rb"]
  	t.verbose = true
  end
end