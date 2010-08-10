require "rake/testtask"
require "rcov/rcovtask"

Rake::TestTask.new do |t|
  t.libs << "test"
  t.libs << File.dirname(__FILE__)
  t.test_files = FileList["test/**/*_test.rb"]
  t.verbose = true
end

Rcov::RcovTask.new do |t|
  t.test_files = FileList["test/**/*_test.rb"]
  t.rcov_opts = ["--sort coverage", "--exclude .bundle,.gem"]

  t.output_dir = "coverage"
  t.libs << "test"
  t.libs << File.dirname(__FILE__)
  t.verbose = true
end
