desc 'run all tests'
task :test do
  test_files = Dir.glob('test/**/*_test.rb').each do |test_file|
    sh "ruby #{test_file}"
  end
end