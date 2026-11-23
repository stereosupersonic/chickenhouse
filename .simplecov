SimpleCov.formatters = SimpleCov::Formatter::MultiFormatter.new([
  SimpleCov::Formatter::HTMLFormatter
])
SimpleCov.configure do
  # The image of the CI run lets the tests write below tmp/ but not into the root of the app.
  coverage_dir ENV.fetch("COVERAGE_DIR", "coverage")

  skip "db"
  skip "config"
  skip "bin"
  skip "spec"
  skip "lib/tasks"
end
